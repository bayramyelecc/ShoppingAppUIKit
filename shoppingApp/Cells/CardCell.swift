//
//  CardCell.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    var models : Model? {
        didSet{
            setupUI()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray6.withAlphaComponent(0.6)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.insetBy(dx: 5, dy: 5)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(){
        
        titleLabel.text = models?.title
        priceLabel.text = "\(String(describing: models!.price)) $"
        
        if let imageUrl = models?.image , let url = URL(string: imageUrl) {
            
            URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
                if let data = data , error == nil, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.customImageView.image = image
                    }
                } else {
                    self?.customImageView.image = UIImage(named: "placeholder")
                }
            }.resume()
            
        } 
    }

    
    
}

