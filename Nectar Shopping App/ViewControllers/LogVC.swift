//
//  LogInVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 30/05/26.
//

import UIKit

class LogInVC: UIViewController {
//MARK: OUTLETS
    @IBOutlet var lbltitle : [UILabel]!
    @IBOutlet weak var lblSocialMsg : UILabel!
//    @IBOutlet weak var txtFldMobileNum : UITextField!
    @IBOutlet weak var btnGoogle : UIButton!
    @IBOutlet weak var btnFacebook : UIButton!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setBackgroundImage(named:"AppBackground")
        self.navigationItem.hidesBackButton = true
    }
    //MARK: Setup
    @IBAction func actnbtnNextScreen(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MobileNumVC") as! MobileNumVC
        self.navigationController?.pushViewController(vc , animated: true)
    }
    private func setUpUI(){
        lbltitle.forEach { labels in
            labels.font = AppFonts.semibold.with(size: 25)
            labels.textColor = AppColors.textBlack
        }
        
        lblSocialMsg.font = AppFonts.regular.with(size: 15)
        lblSocialMsg.textColor = AppColors.textGray
        lblSocialMsg.textAlignment = .center
        
//        txtFldMobileNum.font = AppFonts.medium.with(size: 17)
        
        btnGoogle.configureBtn(title: "Continue with Google", font: AppFonts.semibold.with(size: 19), bgClr: AppColors.googleBlue!, tint: AppColors.textWhite!,border: 0, borderColor: nil)
        btnFacebook.configureBtn(title: "Continue with Facebook", font: AppFonts.semibold.with(size: 19), bgClr: AppColors.facebookBlue!, tint: AppColors.textWhite!,border: 0, borderColor: nil)
    }
    @IBAction func actnBtnGoogle(_ sender: Any) {
        let vc  = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
