//
//  GroceriesCVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 26/06/26.
//

import UIKit

class GroceriesCVC: UICollectionViewCell {

    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblNameItem: UILabel!
    @IBOutlet weak var viewCellBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    private func setUpUI(){
        
        viewCellBG.layer.cornerRadius = 15
        viewCellBG.layer.masksToBounds = true
        viewCellBG.layer.borderColor = AppColors.textGray.cgColor
        viewCellBG.layer.borderWidth = 1
        
        lblNameItem.font = AppFonts.semibold.with(size: 20)
        lblNameItem.textAlignment = .left
        lblNameItem.textColor = AppColors.textBlack
    }
    func configure(with products:ProductsModel){
        imgItem.image = UIImage(named: "\(products.imageName)") ?? UIImage(systemName: "photo")
        lblNameItem.text = products.name
        
    }
}
