//
//  HomeVM.swift
//  
//
//  Created by Goru Saini on 24/06/26.
//

import Foundation
final class HomeVM{
//MARK: Private States

    //private means oonly this class can modify this directly.
    private var allProducts : [ProductsModel] = []
    //Poster Images for Banner
    let posterimages :[String] = ["Poster1","Poster2","Poster3","Poster3"]
    
    var posterCount : Int { posterimages.count}
    
    func poster(at index : Int) -> String {
        return posterimages[index]
    }
    // 'private(set)' means:
    // → OUTSIDE this class: read only  (VC can read but not change)
    // → INSIDE this class:  read/write (ViewModel can change freely)
    private(set) var exclusiveOffers : [ProductsModel] = []
    private(set) var bestSelling : [ProductsModel] = []
    private(set) var grocery : [ProductsModel] = []
    
//MARK: - Binding Closures
    
    //Used when products loaded successfully.
    var onDataUploaded:(()->Void)?
    
    //Used when something goes wrong.
    var onError : ((String)-> Void)?
    
    func fetchProducts(){
        
        //Ask product Services to load products and decode products.json
        let products = ProductServices.loadProducts()
        
        //check if products is not empty
        
        guard !products.isEmpty else {
            onError?("No Products found. Check products.json file is added to target membership")
            return
        }
        //Store all products.
        allProducts = products
        
        //filters all products into sections
        filterProducts()
        
        //tells the viewController to update its ui because all data is updated and ready
        onDataUploaded?()
    }
//MARK: Functions
    
    func exclusiveProducts(at index :Int)-> ProductsModel{
        return exclusiveOffers[index]
    }
    func bestSellingProducts(at index : Int) -> ProductsModel {
        return bestSelling[index]
    }
    func gorcery(at index : Int) -> ProductsModel {
        return grocery[index]
    }
//MARK: - .count for CollView
    
    var exclusiveCount : Int{exclusiveOffers.count}
    var bestSellingCount : Int{bestSelling.count}
    var groceryCount : Int{grocery.count}
    
    private func filterProducts(){
        exclusiveOffers = allProducts.filter{ $0.isExclusive }
        bestSelling = allProducts.filter{ $0.isBestSelling}
        grocery = allProducts.filter{ $0.category == "Groceries"}
    }
}
