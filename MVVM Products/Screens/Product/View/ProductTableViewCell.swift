//
//  ProductTableViewCell.swift
//  MVVM Products
//
//  Created by Prashant Kumar Soni on 27/12/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var cntnrView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    var product: Product? {
        didSet {                // Property Observer
            self.productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cntnrView.clipsToBounds = false
        cntnrView.layer.cornerRadius = 16.0
        cntnrView.backgroundColor = .systemGray6
        
        productImageView.layer.cornerRadius = 16.0
    }
    
}

extension ProductTableViewCell {
    private func productDetailConfiguration() {
        guard let product else { return }
        productTitleLbl.text = product.title
        productCategoryLbl.text = product.category
        descriptionLbl.text = product.description
        priceLbl.text = "$\(product.price)"
        rateBtn.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
}
