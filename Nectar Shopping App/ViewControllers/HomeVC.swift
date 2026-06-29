//
//  HomeVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 14/06/26.
//

import UIKit

class HomeVC: UIViewController {
//MARK: - Outlets
    
    @IBOutlet weak var TabView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var lbltabProfile: UILabel!
    @IBOutlet weak var lblTabFav: UILabel!
    @IBOutlet weak var lblTabCart: UILabel!
    @IBOutlet weak var lblTabExplore: UILabel!
    @IBOutlet weak var lblTabHome: UILabel!
    @IBOutlet weak var vwTabProfile: UIImageView!
    @IBOutlet weak var vwTabFav: UIImageView!
    @IBOutlet weak var vwTabCart: UIImageView!
    @IBOutlet weak var vwTabExplore: UIImageView!
    @IBOutlet weak var vwTabHome: UIImageView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadVC(1)
    }
    //MARK: - Actions
    @IBAction func actnBtnHome(_ sender: Any) {
        loadVC(0)
    }
    @IBAction func actnBtnExplore(_ sender: Any) {
        loadVC(1)
    }
    @IBAction func actnBtnCart(_ sender: Any) {
        loadVC(2)
    }
    @IBAction func actnBtnfavorite(_ sender: Any) {
        loadVC(3)
    }
    @IBAction func actnBtnProfile(_ sender: Any) {
        loadVC(4)
    }
}
extension HomeVC {
    private func setUpUI(){
        TabView.layer.cornerRadius = 20
        TabView.backgroundColor = .white
        TabView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        TabView.layer.shadowColor = AppColors.textBlack.cgColor
        TabView.layer.shadowOpacity = 0.20
        TabView.layer.shadowOffset = CGSize(width: 0, height: 10)
        TabView.layer.shadowRadius = 10
        TabView.layer.masksToBounds = false
    }
    private func loadChild(_ childVC : UIViewController){
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childVC.didMove(toParent: self)
        containerView.sendSubviewToBack(childVC.view)
        view.bringSubviewToFront(TabView)
    }
    private func loadVC(_ selectedTab : Int){
        resetTabAppearance()
       
        
        switch selectedTab {
        case 0 :
            vwTabHome.image = UIImage(named: "TabHome")
            vwTabHome.tintColor = AppColors.primaryGreen
            lblTabHome.text = "Home"
            lblTabHome.textColor = AppColors.primaryGreen
            lblTabHome.font = AppFonts.semibold.with(size: 12)
            let createVC = storyboard?.instantiateViewController(withIdentifier: "MainHomeVC") as! MainHomeVC
            loadChild(createVC)
        case 1 :
            vwTabExplore.image = UIImage(named: "TabExplore")
            vwTabExplore.tintColor = AppColors.primaryGreen
            lblTabExplore.text = "Explore"
            lblTabExplore.textColor = AppColors.primaryGreen
            lblTabExplore.font = AppFonts.semibold.with(size: 12)
            let createVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            loadChild(createVC)
        case 2 :
            vwTabCart.image = UIImage(named: "TabCart")
            vwTabCart.tintColor = AppColors.primaryGreen
            lblTabCart.text = "Cart"
            lblTabCart.textColor = AppColors.primaryGreen
            lblTabCart.font = AppFonts.semibold.with(size: 12)
            let createVC = storyboard?.instantiateViewController(withIdentifier: "MainHomeVC") as! MainHomeVC
            loadChild(createVC)
        case 3 :
            vwTabFav.image = UIImage(named: "TabFavorite")
            vwTabFav.tintColor = AppColors.primaryGreen
            lblTabFav.text = "Favorite"
            lblTabFav.textColor = AppColors.primaryGreen
            lblTabFav.font = AppFonts.semibold.with(size: 12)
            let createVC = storyboard?.instantiateViewController(withIdentifier: "MainHomeVC") as! MainHomeVC
            loadChild(createVC)
        case 4 :
            vwTabProfile.image = UIImage(named: "TabProfile")
            vwTabProfile.tintColor = AppColors.primaryGreen
            lbltabProfile.text = "Profile"
            lbltabProfile.textColor = AppColors.primaryGreen
            lbltabProfile.font = AppFonts.semibold.with(size: 12)
            let createVC = storyboard?.instantiateViewController(withIdentifier: "MainHomeVC") as! MainHomeVC
            loadChild(createVC)
        default :
            break
        }
    
    }
    private func resetTabAppearance(){
        lblTabHome.textColor = AppColors.textBlack
        vwTabHome.tintColor = AppColors.textBlack
        lblTabHome.font = AppFonts.medium.with(size: 12)
        
        lblTabExplore.textColor = AppColors.textBlack
        vwTabExplore.tintColor = AppColors.textBlack
        lblTabExplore.font = AppFonts.medium.with(size: 12)
        
        lblTabCart.textColor = AppColors.textBlack
        vwTabCart.tintColor = AppColors.textBlack
        lblTabCart.font = AppFonts.medium.with(size: 12)
        
        lblTabFav.textColor = AppColors.textBlack
        vwTabFav.tintColor = AppColors.textBlack
        lblTabFav.font = AppFonts.medium.with(size: 12)
        
        lbltabProfile.textColor = AppColors.textBlack
        vwTabProfile.tintColor = AppColors.textBlack
        lbltabProfile.font = AppFonts.medium.with(size: 12)
    }
}
