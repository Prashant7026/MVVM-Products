//
//  AddProductViewController.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 29/12/24.
//

import UIKit

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        addProduct()
    }
}

// MARK: POST without Generic
/*
extension AddProductViewController {
    private func addProduct() {
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
        
        let param = AddProduct(title: "BMW Pencil")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Model to Data Convert 'JSONEncoder().encode(__ )'
        request.httpBody = try? JSONEncoder().encode(param)
        request.allHTTPHeaderFields = [
            "Content-Type" : "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            do{
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                print("-----\n\(productResponse)")
            } catch {
                print(error)
            }
        }.resume()
    }
}
*/
