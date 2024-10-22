//
//  UIViewController+Convenience.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import PKHUD

extension UIViewController {

    var isViewVisible: Bool {
        return isViewLoaded && view.window != nil
    }

    func topViewController() -> UIViewController {
        if let controller = (self as? UINavigationController)?.visibleViewController {
            return controller.topViewController()
        } else if let controller = (self as? UITabBarController)?.selectedViewController {
            return controller.topViewController()
        } else if let controller = presentedViewController {
            return controller.topViewController()
        }
        return self
    }
    
    func showHUD() {
        HUD.show(.progress)
    }

    func hideHUD() {
        HUD.hide()
    }

    func applyDefaultAppearance() {
        let apperance = UINavigationBar.appearance()
        navigationItem.standardAppearance = apperance.standardAppearance
        navigationItem.scrollEdgeAppearance = apperance.scrollEdgeAppearance
    }

    func pushViewController(_ controller: UIViewController, animated: Bool = true, hideTabBar: Bool = false) {
        controller.hidesBottomBarWhenPushed = hideTabBar
        navigationController?.pushViewController(controller, animated: animated)
    }

    func closeController() {
        guard presentingViewController != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        dismiss(animated: true)
    }

}
