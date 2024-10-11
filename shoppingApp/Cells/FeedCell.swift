//
//  FeedCell.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    var tabBarControllerRef: UITabBarController?
    
    
    var models : Model? {
        didSet{
            setupUI()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        //sepete ekle
        
        CartManager.shared.addProduct(models!)
        print("\(String(describing: models?.title)) sepete eklendi!")
        
        // alert
        
        let alert = UIAlertController(title: "Ürün sepete eklendi !", message: "Ne yapmak istiyorsun ?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Devam et", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sepete git", style: .cancel, handler: { _ in
            self.tabBarControllerRef?.selectedIndex = 1
        }))
        
        if let viewController = tabBarControllerRef {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    private func setupUI(){
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        
        titleLabel.text = models?.title
        priceLabel.text = "\(String(describing: models!.price)) $"
        imageView.contentMode = .scaleAspectFit
        
        if let url = models?.image , let imageUrl = URL(string: url) {
            
            URLSession.shared.dataTask(with: imageUrl) {[weak self] data, response, error in
                if let data = data , error == nil, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                } else {
                    self?.imageView.image = UIImage(named: "placeholder")
                }
            }.resume()
            
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}

