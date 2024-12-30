//
//  ProductCardService.swift
//  ANF Code Test
//
//  Created by joie gisele mukamisha on 12/29/24.
//

import Foundation

class ProductCardService {
 
    static let shared = ProductCardService()
    private let apiURL = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
    func fetchPromotions(completion: @escaping (Result<[ProductCard], Error>) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 500, userInfo: nil)))
                return
            }

            do {
                let promotions = try JSONDecoder().decode([ProductCard].self, from: data)
                completion(.success(promotions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
