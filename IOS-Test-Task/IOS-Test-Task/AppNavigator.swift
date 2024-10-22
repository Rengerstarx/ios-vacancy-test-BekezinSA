//
//  AppNavigator.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import UIKit

class AppNavigator {

    static let shared = AppNavigator()

    private(set) var window: UIWindow!

    var topViewController: UIViewController? {
        return window.rootViewController?.topViewController()
    }

    func setupRootNavigationInWindow(_ window: UIWindow) {
        self.window = window
        window.rootViewController = GistListViewController(/*showTrialPage: showTrialPage*/)
    }

}
