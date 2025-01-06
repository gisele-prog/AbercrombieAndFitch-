//
//  ProductCardService.swift
//  ANF Code Test
//
//  Created by joie gisele mukamisha on 12/29/24.
//

import Foundation

// Custom Error enum for better error handling
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkFailure(Error)
}

class ProductCardService {
    
    static let shared = ProductCardService()
    
    // Default API URL, can be changed for testing or other environments
    private let apiURL = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
    
    // Fetch promotions method, now with improved error handling
    func fetchPromotions(completion: @escaping (Result<[ProductCard], NetworkError>) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(.failure(.invalidURL))  // Return specific error for invalid URL
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Handle network error
            if let error = error {
                completion(.failure(.networkFailure(error)))
                return
            }
            
            // Handle case where no data is received
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Decode data into ProductCard objects
            do {
                let promotions = try JSONDecoder().decode([ProductCard].self, from: data)
                completion(.success(promotions))
            } catch {
                completion(.failure(.decodingError))  // Provide more specific decoding error
            }
        }.resume()
    }
}
