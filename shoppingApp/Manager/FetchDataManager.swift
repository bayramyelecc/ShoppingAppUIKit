//
//  FetchDataManager.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

import Foundation

class FetchDataManager {
    
    var models: [Model] = []
    
    func fetchData(completion: @escaping () -> Void){
        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            print("url hatası")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data, error == nil else {
                print("hata")
                return
            }
            do{
                let model = try JSONDecoder().decode([Model].self, from: data)
                DispatchQueue.main.async {
                    self?.models = model
                    completion()
                }
            } catch {
                print("hataaa")
            }
        }
        task.resume()
        
    }
    
}

