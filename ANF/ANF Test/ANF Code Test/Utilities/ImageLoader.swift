//
//  ImageLoader.swift
//  ANF Code Test
//
//  Created by joie gisele mukamisha on 12/30/24.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func loadAsyncImage(from url: URL,completion: @escaping (UIImage) -> Void) {
        // Check the cache
        if let cachedImage = cache.object(forKey: url as NSURL) {
            //imageView.image = cachedImage
            completion(cachedImage)
            return
        }

        // Download the image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else {
                return
            }

            // Cache the image
            self.cache.setObject(image, forKey: url as NSURL)

            // Set the image on the main thread
            DispatchQueue.main.async {
               completion(image)
            }
        }
        task.priority = URLSessionTask.highPriority // Increase download priority
        task.resume()
    }
}
