//
//  File.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var products: [Model] = []
    
    func addProduct(_ product: Model) {
        products.append(product)
    }
    
    func totalPrice() -> Double {
        return products.reduce(0) { $0 + $1.price }
    }
}
