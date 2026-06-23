//
//  MainHomeVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 22/06/26.
//

import UIKit

class MainHomeVC: UIViewController {
    @IBOutlet weak var lblLocationName : UILabel!
    @IBOutlet weak var vwBackground : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    private func setUpUI(){
        lblLocationName.textColor = AppColors.textBlack
        lblLocationName.font = AppFonts.semibold.with(size: 18)
        
        if  let savedLocation = UserDefaults.standard.string(forKey: "selectedLocation"){
            lblLocationName.text = savedLocation
        }
    }

}
