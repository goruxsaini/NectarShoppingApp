//
//  OnBoardingVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 29/05/26.
//

import UIKit

class OnBoardingVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var backgroundImage : UIImageView!
    @IBOutlet weak var logoImage : UIImageView!
    @IBOutlet weak var lbltitle : UILabel!
    @IBOutlet weak var lbltitle2 : UILabel!
    @IBOutlet weak var lblSubtitle : UILabel!
    @IBOutlet weak var getStartedButton : UIButton!
    
    //MARK: Properties
    private let viewModel = OnBoardingVM()
    
    //MARK: ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
        self.navigationItem.hidesBackButton = true
    }
    private func setupUI(){
        getStartedButton.configureBtn(title: "Get Started",font: AppFonts.semibold.with(size: 20),bgClr: AppColors.primaryGreen,tint: AppColors.textWhite!,cornerRadius: 15, border: 0,borderColor: nil)
    }
    private func configure(){
        backgroundImage.image = UIImage(named: viewModel.imageName)
        backgroundImage.contentMode = .scaleAspectFill
        
        logoImage.image = UIImage(named: viewModel.logoImage)
        
        lbltitle.text = viewModel.title
        lbltitle.font = AppFonts.bold.with(size: 45)
        lbltitle.textColor = AppColors.textWhite
        
        lbltitle2.text = viewModel.title2
        lbltitle2.font = AppFonts.bold.with(size: 45)
        lbltitle2.textColor = AppColors.textWhite
        
        lblSubtitle.text = viewModel.subtitle
        lblSubtitle.font = AppFonts.light.with(size: 17)
        lblSubtitle.textColor = AppColors.textWhite
    }
}
//MARK: Actions
extension OnBoardingVC{
    @IBAction func actnBtnGetStarted(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "SignInVC"
        ) as! SignInVC
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
}
