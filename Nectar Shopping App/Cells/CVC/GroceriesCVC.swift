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
    @IBOutlet weak var vwBackgroundCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    private func setUpUI(){
        vwBackgroundCell.layer.cornerRadius = 15
        vwBackgroundCell.layer.masksToBounds = true
        
    }
}
