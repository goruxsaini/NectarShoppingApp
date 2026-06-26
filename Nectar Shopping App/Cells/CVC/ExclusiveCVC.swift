//
//  ExclusiveCVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 25/06/26.
//

import UIKit

class ExclusiveCVC: UICollectionViewCell {
    @IBOutlet weak var ItemView: UIView!
    @IBOutlet weak var imgVwItem: UIImageView!
    @IBOutlet weak var lblNameItem: UILabel!
    @IBOutlet weak var lblItemQuantity: UILabel!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var lblItemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    func configure(with product : ProductsModel){
        lblNameItem.text = product.name
        imgVwItem.image = UIImage(named: product.imageName) ?? UIImage(systemName: "photo")
        lblItemPrice.text = "₹ \(product.price)"
        lblItemQuantity.text = product.unit
    }
    private func setUpUI(){
        lblNameItem.font = AppFonts.semibold.with(size: 16 )
        lblNameItem.textColor = AppColors.textBlack
        
        lblItemQuantity.font = AppFonts.medium.with(size: 12)
        lblItemQuantity.textColor = AppColors.textGray
        
        lblItemPrice.font = AppFonts.bold.with(size: 15)
        lblItemPrice.textColor = AppColors.textBlack
        
        btnAddItem.configureBtn(title: nil, font:nil , bgClr: .primaryGreen, tint: .white, cornerRadius: 10, border: 0, borderColor: nil)
        btnAddItem.backgroundColor = AppColors.primaryGreen
        
        ItemView.layer.cornerRadius = 10
        ItemView.layer.borderWidth = 1
        ItemView.layer.borderColor = AppColors.textGray.cgColor
        ItemView.tintColor = AppColors.primaryGreen
        
    }
}
