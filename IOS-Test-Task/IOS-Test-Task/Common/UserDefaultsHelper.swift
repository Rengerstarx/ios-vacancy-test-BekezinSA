//
//  UserDefaultsHelper.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 23.10.2024.
//

import Foundation

class UserDefaultsHelper {

    private let gistsKey = "cachedGists"

    func saveGists(_ gists: [String: GitHubGist]) {
        if let encoded = try? JSONEncoder().encode(gists) {
            UserDefaults.standard.set(encoded, forKey: gistsKey)
        }
    }

    func loadGists() -> [String: GitHubGist]? {
        if let savedGists = UserDefaults.standard.object(forKey: gistsKey) as? Data {
            if let decodedGists = try? JSONDecoder().decode([String: GitHubGist].self, from: savedGists) {
                return decodedGists
            }
        }
        return nil
    }
    
}
