//
//  ProductEndPoint.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 29/12/24.
//

import Foundation

// Modules(Screens)
enum ProductEndPoint {
    case products                           // GET
    case addProduct(product: AddProduct)    // POST
}

//"https://fakestoreapi.com/products"
extension ProductEndPoint: EndPointType {
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseURL: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: (any Encodable)? {
        switch self {
        case .products:
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return APIManager.commonAPIHeader
    }
}
