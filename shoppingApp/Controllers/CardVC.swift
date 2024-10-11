//
//  CardVC.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

import UIKit

class CardVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sepet"
        navigationController?.navigationBar.barTintColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        updateTotalPrice()
        self.view.viewWithTag(1)?.layer.cornerRadius = 20
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.viewWithTag(1)?.frame = (self.view.viewWithTag(1)?.frame.insetBy(dx: 10, dy: 0))!
    }
    
    @IBAction func cartButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sepeti onaylıyor musunuz ?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Onayla", style: .default, handler: { _ in
            
            let twoAlert = UIAlertController(title: "Sepet onaylanıyor..", message: "", preferredStyle: .alert)
            self.present(twoAlert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                twoAlert.dismiss(animated: true) {
                    CartManager.shared.products.removeAll()
                    self.tableView.reloadData()
                    self.updateTotalPrice()
                    
                    let threeAlert = UIAlertController(title: "Ödeme Başarılı ✅", message: "", preferredStyle: .alert)
                    threeAlert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                        
                    }))
                    self.present(threeAlert, animated:true, completion: nil)
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "İptal et", style: .destructive, handler: { _ in
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateTotalPrice(){
        
        let total = CartManager.shared.totalPrice()
        totalPriceLabel.text = String(format: "%.2f $", total)
        
        if totalPriceLabel.text == String(format: "%.2f $", 0.0) {
            self.view.viewWithTag(1)?.isHidden = true
        }
        else{
            self.view.viewWithTag(1)?.isHidden = false
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardCell
        let product = CartManager.shared.products[indexPath.row]
        cell.models = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            
            CartManager.shared.products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            self.updateTotalPrice()
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    
    
}


