//
//  ProductServices.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 24/06/26.
//


// in this file we have three Guards.
//Guard1 for loacting or finding the file.
//Guard2 for reading the file.
//Guard3 for decoding the file.
import Foundation
class ProductServices{
    static func loadProducts() -> [ProductsModel] {
        //here bundle main is used because we stored the data in json and bundle.main is used for using everything that is in your xcode project.
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("ProductJson = products.json not found in your bundle")
            return []
        }
        guard let data = try? Data(contentsOf: url) else {
            print("ProductService: Failed to read the products.")
            return[]
        }
        guard let products = try?JSONDecoder().decode([ProductsModel].self, from: data) else {
            print("ProductService : failed to decode product.json")
            return []
        }
        print("ProductService : loaded \(products.count) products.")
        return products
    }
    
}
