//
//  EndPointType.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 28/12/24.
//

import Foundation

// API hit HTTP Mehtods
enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

// Useful things for api
protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
}

// Modules(Screens)
enum EndPointItems {
    case products
}

//"https://fakestoreapi.com/products"
extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var baseURL: String {
        return "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        }
    }
}
