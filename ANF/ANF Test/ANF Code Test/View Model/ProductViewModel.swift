//
//  ProductViewModel.swift
//  ANF Code Test
//
//  Created by joie gisele mukamisha on 1/2/25.
//

import Combine
import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [ProductCard] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProducts(completion: @escaping (Error?) -> Void) {
        ProductCardService.shared.fetchPromotions { result in
            switch result {
            case .success(let products):
                self.products = products
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
