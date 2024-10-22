//
//  ImageCacheManager.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 23.10.2024.
//

import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, for gistId: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: gistId as NSString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: gistId as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil) // Ошибка загрузки
                }
            }
        }
        task.resume()
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
