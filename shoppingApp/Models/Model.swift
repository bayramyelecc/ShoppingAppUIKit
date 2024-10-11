//
//  Model.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

import Foundation


struct Model: Codable {
    
    let id: Int?
    let title: String?
    let price: Double
    let description: String?
    let category: String?
    let image: String?
    let rating: altSinif
    
}

struct altSinif : Codable {
    
    let rate: Double?
    let count: Int?
    
}

