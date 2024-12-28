//
//  APIManager.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 18/12/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error: Error?)
}

// typealias Handler = (Result<[Product], DataError>) -> Void
 typealias Handler<T> = (Result<T, DataError>) -> Void

// ~~~~~~~~~~~~~~~~~~ Singleton Deisgn Pattern

final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func request<T: Decodable>(                     // Coz Product Model is confirming to Decodable Protocol
        modelType: T.Type,                          // ----> Inside do block: [Product].self
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            // Ensure `response` is an `HTTPURLResponse` and the status code is within 200-299 (successful responses). If not, return a failure with `.invalidResponse`.
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
                return
            } catch {
                completion(.failure(.network(error)))
                return
            }
        }.resume()
    }
    
    /*
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            // Ensure `response` is an `HTTPURLResponse` and the status code is within 200-299 (successful responses). If not, return a failure with `.invalidResponse`.
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
                return
            } catch {
                completion(.failure(.network(error)))
                return
            }
        }.resume()
    }
     */
}


// singleton = singleton class ka object create hoga outside class means in a singleton class we not make initializer as a private
// Singleton(Prefer always) = Singleton class ka object create nahi hoga outside class means in a Singleton class we make initializer as a private
