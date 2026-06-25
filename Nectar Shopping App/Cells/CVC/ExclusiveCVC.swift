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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    private func setUpUI(){
        lblNameItem.font = AppFonts.bold.with(size: 22)
        lblNameItem.textColor = AppColors.textBlack
        
        lblItemQuantity.font = AppFonts.medium.with(size: 15)
        lblItemQuantity.textColor = AppColors.textGray
        
        btnAddItem.configureBtn(title: nil, font: AppFonts.bold.with(size: 25), bgClr: .primaryGreen, tint: .white, cornerRadius: 10, border: 0, borderColor: nil)
        
        ItemView.layer.cornerRadius = 10
        ItemView.layer.borderWidth = 1
        ItemView.layer.borderColor = AppColors.textBlack.cgColor    }
}
