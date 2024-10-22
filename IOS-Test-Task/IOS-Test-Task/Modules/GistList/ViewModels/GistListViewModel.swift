//
//  GistListViewModel.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import Foundation
import Combine
import UIKit

// MARK: - Action Enum
enum GistListAction {
    case sortByAvatarPresence
    case sortByPublicStatus
    case fetchAllGists
    case resetFilters
}

class GistListViewModel {
    
    @Published private var fullGistList = [String: GitHubGist]()
    @Published private(set) var sortedGists = [GistListItemModel]()
    @Published private(set) var error: Error?
    
    private let gistService = GitHubGistService()
    private let userDefaultsHelper = UserDefaultsHelper()
    private let imageCacheManager = ImageCacheManager.shared
    
    private var observables: [AnyCancellable] = []
    let action = PassthroughSubject<GistListAction, Never>()
    
    private var gistItems = [GistListItemModel]()
    
    init() {
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.performAction(action)
            }
            .store(in: &observables)
        
        if let cachedGists = userDefaultsHelper.loadGists() {
            self.fullGistList = cachedGists
            self.prepareGistItems(gists: cachedGists)
        }
    }
    
    // MARK: - Prepare Gist Items
    private func prepareGistItems(gists: [String: GitHubGist]) {
        self.gistItems = gists.map { (key, gist) in
            GistListItemModel(
                gistName: gist.id,
                authorAvatar: UIImage(),
                authorNickname: gist.owner?.login ?? "Unknown",
                isPublic: gist.isPublic
            )
        }
        self.sortedGists = self.gistItems
        loadAvatarsForGists(gists: gists)
    }
    
    // MARK: - Load Avatars for Gists
    private func loadAvatarsForGists(gists: [String: GitHubGist]) {
        for (gistId, gist) in gists {
            if let avatarUrl = gist.owner?.avatarURL {
                imageCacheManager.loadImage(from: avatarUrl, for: gistId) { [weak self] image in
                    guard let self = self, let image = image else { return }
                    
                    if let index = self.gistItems.firstIndex(where: { $0.gistName == gistId }) {
                        self.gistItems[index].authorAvatar = image
                        self.sortedGists = self.gistItems
                    }
                }
            }
        }
    }
    
    // MARK: - Perform Action
    func performAction(_ action: GistListAction) {
        switch action {
        case .sortByAvatarPresence:
            sortByAvatarPresence()
        case .sortByPublicStatus:
            sortByPublicStatus()
        case .fetchAllGists:
            fetchAllGists()
        case .resetFilters:
            resetFilters()
        }
    }
    
    func getGistById(id: String) -> GitHubGist? {
        return fullGistList[id]
    }
    
    private func sortByAvatarPresence() {
        sortedGists = gistItems.filter { $0.authorAvatar != UIImage() }
    }
    
    private func sortByPublicStatus() {
        sortedGists = gistItems.filter { $0.isPublic }
    }
    
    private func fetchAllGists() {
        gistService.completion = { [weak self] result in
            switch result {
            case .success(let gists):
                let gistsMap = Dictionary(uniqueKeysWithValues: gists.map { ($0.id, $0) })
                self?.fullGistList = gistsMap
                self?.prepareGistItems(gists: gistsMap)
                
                self?.userDefaultsHelper.saveGists(self?.fullGistList ?? [:])
                
            case .failure(let error):
                self?.error = error
            }
        }
        gistService.fetchGists()
    }
    
    private func resetFilters() {
        sortedGists = gistItems
    }
}
