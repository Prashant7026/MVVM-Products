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
    var body: Encodable? { get }
    var headers: [String : String]? { get }
}
