//
//  ProductTableViewCell.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

   
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.applyTheme()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func applyTheme() {
        self.cardView.layer.cornerRadius = 5
        self.imgView.layer.borderWidth = 0.2
        self.imgView.layer.cornerRadius = 1
        self.cardView.layer.shadowColor = UIColor.gray.cgColor
        self.cardView.layer.shadowOpacity = 0.5
        self.cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
