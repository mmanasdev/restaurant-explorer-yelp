//
//  ListTableViewCell.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 26/10/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var punctuationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        nameLabel.text = ""
//        addressLabel.text = ""
//        punctuationLabel.text = ""
//        priceLabel.text = ""
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
