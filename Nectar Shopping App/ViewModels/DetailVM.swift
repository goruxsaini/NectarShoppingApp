//
//  DetailVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 29/06/26.
//

import Foundation
final class DetailVM {
    let products : ProductsModel
    
    private(set) var quantity = 1
    
    init(products: ProductsModel) {
        self.products = products
    }
    
    func increaseQuantity(){
        quantity += 1
    }
    func decreaseQuantity(){
        if quantity > 1 {
            quantity -= 1
        }
    }
    
    var totalPrice : Int {
        (products.originalPrice ) * quantity
    }
    var formattedTotalPrice : String {
        "₹\(totalPrice)"
    }
}

