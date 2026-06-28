//
//  ProductsModel.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 24/06/26.
//

import Foundation
struct ProductsModel: Codable {
    let id: Int
    let name: String
    let category: String
    let price: Int
    let originalPrice: Int
    let unit: String
    let imageName: String
    let description: String
    let rating: Double
    let reviewCount: Int
    let isAvailable: Bool
    let isFeatured: Bool
    let isExclusive: Bool
    let isBestSelling: Bool
    let isGrocery : Bool
    let brand: String

    //check if the product has discount or not.
    var hasDiscount: Bool { price < originalPrice }
    //it first checks if the product has discount if not returns 0 and if has then calculate.
    var discountPercentage: Int {
        guard hasDiscount else { return 0 }
        return Int(((originalPrice - price) / originalPrice) * 100)
    }
    // convert the price from 490 to ₹490
    var formattedPrice: String {
            return "₹\(price)"
    }

    var formattedOriginalPrice: String {
            return "₹\(originalPrice)"
    }
}
