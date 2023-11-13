//
//  DetailViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 11/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var urlAddress: UITextView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let business: Business!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillBussinessParams()
    }
    
    init(business: Business) {
        self.business = business
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillBussinessParams() {
        self.nameLabel.text = business.name
        self.addressLabel.text = business.location?.displayFullAdress()
        self.phoneLabel.text = business.displayPhone
        self.rateLabel.text =  business.rating?.description
        self.priceLabel.text = business.price
        if let imageURLString = business.imageURL, let imageURL = URL(string: imageURLString) {
            self.photoImage.downloadImage(from: imageURL)
        }
        
        if let businessURLString = business.url {
            let attributedString = NSMutableAttributedString(string: urlAddress.text)
            attributedString.addAttribute(.link, value: businessURLString, range: NSRange(location: 0, length: urlAddress.text.count))
            self.urlAddress.attributedText = attributedString
            self.urlAddress.isUserInteractionEnabled = true
            self.urlAddress.isEditable = false
        }
    }
}

extension UIImageView {
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
