//
//  LocalizedStrings.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import Foundation

extension String {

    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    enum Greeting: String {
        
        case greetingMainTitle
        case greetingDescriptionTitle
        
    }
    
    enum GistError: String {
        
        case gistErrorInvalidURLTitle
        case gistErrorNoDataTitle
        case gistErrorUnauthorizedTitle
        case gistErrorForbiddenTitle
        case gistErrorNotFoundTitle
        case gistErrorServerErrorTitle
        case gistErrorDecodingErrorTitle
        case gistErrorUnknownErrorString
        
    }
    
}

extension RawRepresentable {

    func format(_ args: CVarArg...) -> String {
        let format = ^self
        return String(format: format, arguments: args)
    }

}

prefix operator ^
prefix func ^ <Type: RawRepresentable>(_ value: Type) -> String {
    if let raw = value.rawValue as? String {
        let key = raw.capitalizeFirstLetter()
        return NSLocalizedString(key, comment: "")
    }
    return ""
}
