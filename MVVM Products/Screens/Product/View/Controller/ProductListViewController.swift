//
//  ProductListViewController.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 27/12/24.
//

import UIKit

class ProductListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    // MARK: Variables
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }

}

extension ProductListViewController {
    private func configuration() {
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        initViewModel()
        observeEvent()
    }
    
    private func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data Binding observe here - Communication
    private func observeEvent() {
        viewModel.eventHandler = { [weak self] result in
            guard let self else { return }
            switch result {
            case .startLoading:
                DispatchQueue.main.async {
                    self.progressView.startAnimating()
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    self.progressView.stopAnimating()
                }
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.product[indexPath.row]
        cell.product = product
        cell.selectionStyle = .none
        
        return cell
    }
}
