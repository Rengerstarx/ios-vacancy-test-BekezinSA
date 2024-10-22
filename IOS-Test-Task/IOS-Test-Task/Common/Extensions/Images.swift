//
//  Images.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import UIKit

enum AppImage: String {

    // System
    case sfSquareAndArrowUp = "square.and.arrow.up"
    case sfChevronRight = "chevron.right"
    case sfPersonCircle = "person.circle"
    case sfClearCircle = "clear"
    case sfLock = "lock"

    var uiImage: UIImage? {
        return UIImage(named: rawValue) ?? UIImage(systemName: rawValue)
    }

    func uiImageWith(font: UIFont? = nil, tint: UIColor? = nil) -> UIImage? {
        var img = uiImage
        if let font = font {
            img = img?.withConfiguration(UIImage.SymbolConfiguration(font: font))
        }
        if let tint = tint {
            return img?.withTintColor(tint, renderingMode: .alwaysOriginal)
        } else {
            return img
        }
    }

}

