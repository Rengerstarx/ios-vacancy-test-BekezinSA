//
//  GistListViewController.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import UIKit

class GistListViewController: UIViewController {
    
    let gistService = GitHubGistService()

    override func viewDidLoad() {
        super.viewDidLoad()
        gistService.completion = { result in
            switch result {
            case .success(let gists):
                print("Получено \(gists.count) гистов:")
                gists.forEach { gist in
                    print("Gist ID: \(gist.id), URL: \(gist.url)")
                }
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }
        gistService.fetchGists()
    }


}

