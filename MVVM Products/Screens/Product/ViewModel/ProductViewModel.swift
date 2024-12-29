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
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPoint.products) { result in
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
    
    /*
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
     */
    
    func addProduct(_ addProduct: AddProduct) {
        self.eventHandler?(.startLoading)
        APIManager.shared.request(
            modelType: AddProduct.self,
            type: ProductEndPoint.addProduct(product: addProduct)) { result in
                self.eventHandler?(.stopLoading)
                switch result{
                case .success(let product):
                    self.eventHandler?(.newProductAdded(product: product))
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

// MARK: Data Binding
extension ProductViewModel {
    enum Event{
        case startLoading, stopLoading, dataLoaded, error(Error?)
        case newProductAdded(product: AddProduct)
    }
}
