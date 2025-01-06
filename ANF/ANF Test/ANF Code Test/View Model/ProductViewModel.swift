//
//  ProductViewModel.swift
//  ANF Code Test
//
//  Created by joie gisele mukamisha on 1/2/25.
//

class ProductViewModel {
    
    var products: [ProductCard] = []
    var errorMessage: String?
    
    var onDataChanged: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchProducts(completion: @escaping (Error?) -> Void) {
        ProductCardService.shared.fetchPromotions { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                print("Products fetched successfully: \(products)")  // Debugging line
                completion(nil)
            case .failure(let error):
                print("Failed to fetch products: \(error.localizedDescription)")  // Debugging line
                completion(error)
            }
        }
    }
}

