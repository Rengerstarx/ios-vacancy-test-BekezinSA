//
//  GistListViewController.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import UIKit
import Combine

class GistListViewController: UIViewController {

    private let viewModel = GistListViewModel()
    private let gistListView = GistListView()
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var avatarButton: UIBarButtonItem = {
        UIBarButtonItem(
            image: AppImage.sfPersonCircle.uiImageWith(font: .systemFont(ofSize: 16), tint: .appSystemBlue),
            style: .plain,
            target: self,
            action: #selector(filterByAvatar)
        )
    }()
    
    private lazy var resetButton: UIBarButtonItem = {
        UIBarButtonItem(
            image: AppImage.sfClearCircle.uiImageWith(font: .systemFont(ofSize: 16), tint: .appSystemBlue),
            style: .plain,
            target: self,
            action: #selector(resetFilter)
        )
    }()
    
    private lazy var privacyButton: UIBarButtonItem = {
        UIBarButtonItem(
            image: AppImage.sfLock.uiImageWith(font: .systemFont(ofSize: 16), tint: .appSystemBlue),
            style: .plain,
            target: self,
            action: #selector(filterByPrivacy)
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        setupBindings()
        fetchAllGists()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.isHidden = false
        
        title = ^String.GistList.gistListAllGistsTitle
        
        navigationItem.rightBarButtonItems = [avatarButton, privacyButton]
        navigationItem.leftBarButtonItems = [resetButton]
        
        // Настраиваем pull-to-refresh в GistListView
        gistListView.onRefresh = { [weak self] in
            self?.reloadGists() // При pull-to-refresh вызываем обновление данных
        }
        
        gistListView.completion = { [weak self] id in
            print(self?.viewModel.getGistById(id: id))
        }
    }
    
    private func setupLayouts() {
        view.addSubview(gistListView)
        gistListView.edgesToSuperview()
    }
    
    private func setupBindings() {
        viewModel.$sortedGists
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gists in
                self?.gistListView.updateGists(with: gists)
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { error in
                print("Error: \(error.localizedDescription)")
            }
            .store(in: &cancellables)
    }
    
    @objc private func reloadGists() {
        viewModel.performAction(.fetchAllGists)
    }
    
    @objc private func resetFilter() {
        viewModel.performAction(.resetFilters)
    }
    
    @objc private func filterByAvatar() {
        viewModel.performAction(.sortByAvatarPresence)
    }
    
    @objc private func filterByPrivacy() {
        viewModel.performAction(.sortByPublicStatus)
    }
    
    private func fetchAllGists() {
        viewModel.performAction(.fetchAllGists)
    }
    
}
