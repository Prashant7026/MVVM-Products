//
//  ProductViewModel.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 27/12/24.
//

import Foundation

final class ProductViewModel {
    var product: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)?    // Data Binding
    
    func fetchProducts() {
        self.eventHandler?(.startLoading)
        APIManager.shared.fetchProducts { result in
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let productList):
                self.product = productList
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

// MARK: Data Binding
extension ProductViewModel {
    enum Event{
        case startLoading, stopLoading, dataLoaded, error(Error?)
    }
}
