//
//  DetailVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 29/06/26.
//

import UIKit

class DetailVC: UIViewController {
//MARK: - Outlets
    @IBOutlet weak var imgVwItem: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemWeight: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblItemQuantity: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK: - Properties
    var viewModel : DetailVM?
    var isFavorite : Bool = false
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    //MARK: - Functions
    
    private func setUpUI(){
        viewBackground.layer.cornerRadius = 30
        viewBackground.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        viewBackground.layer.masksToBounds = true
        viewBackground.backgroundColor = AppColors.detailCellBg
        
        lblItemName.font = AppFonts.bold.with(size: 25)
        lblItemName.textColor = AppColors.textBlack
        lblItemName.text = viewModel?.products.name
        
        lblItemWeight.font = AppFonts.medium.with(size: 15)
        lblItemWeight.textColor = AppColors.textGray
        lblItemWeight.text = viewModel?.products.unit
        
        lblItemPrice.font = AppFonts.bold.with(size: 20)
        lblItemPrice.textColor = AppColors.textBlack
        lblItemPrice.text = viewModel?.products.formattedPrice
        
        lblItemQuantity.font = AppFonts.medium.with(size: 17)
        lblItemQuantity.contentMode = .center
        lblItemQuantity.layer.cornerRadius = 10
        lblItemQuantity.layer.borderWidth = 0.5
        lblItemQuantity.layer.borderColor = AppColors.textGray.cgColor
        
        btnAdd.tintColor = AppColors.primaryGreen
        btnMinus.tintColor = AppColors.textGray
        
        
        
        updateFavoriteBtn()
        
    }
    private func updateFavoriteBtn(){
        let notFav =  "heart"
        let fav = "heart.fill"
        let imagename = isFavorite ? fav : notFav
        btnFav.setImage(UIImage(systemName:imagename ), for: .normal)
        btnFav.tintColor = isFavorite ? .systemRed : .black
    }
    //MARK: - Actions
    
    @IBAction func actnBtnBack(_ sender: Any) {
        print("Back Pressed")
        backToPop()
    }
    
    @IBAction func actnBtnFavorite(_ sender: Any) {
        isFavorite.toggle()
        updateFavoriteBtn()
    }
    @IBAction func actnBtnShare(_ sender: Any) {
        print("share Pressed")
    }
    @IBAction func actnBtnIncrease(_ sender: Any) {
        viewModel?.increaseQuantity()
        lblItemQuantity.text = "\(viewModel?.quantity)"
        lblItemPrice.text = viewModel?.formattedTotalPrice
    }
    @IBAction func actnBtnDecrease(_ sender: Any) {
        viewModel?.decreaseQuantity()
        lblItemQuantity.text = "\(viewModel?.quantity)"
        lblItemPrice.text = viewModel?.formattedTotalPrice
    }
}
