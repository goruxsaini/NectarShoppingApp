//
//  SignInVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 07/06/26.
//

import UIKit

class SignInVC: UIViewController {
//MARK: Outlets
    
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVwLogo: UIImageView!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var viewModel = LoginVM()
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(named: "AppBackground")
        setUpUI()
        dismissKeyboardOntap()
        btnLogin.configureBtn(title: "Login", font: AppFonts.semibold.with(size: 20), bgClr: .primaryGreen, tint: .white, border: 1, borderColor: AppColors.textBlack)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtFldEmail.text = ""
        txtFldPassword.text = ""
    }
    //MARK: - Functions
    
    private func setUpUI(){
        imgVwLogo.image = UIImage(named: "AppLogoColored")
        imgVwLogo.contentMode = .scaleAspectFit
        
        lblTitle.text = "Login"
        lblTitle.font = AppFonts.semibold.with(size: 30)
        lblTitle.textColor = AppColors.textBlack
        
        lblSubtitle.text = "Enter you email and password"
        lblSubtitle.textColor = AppColors.textGray
        lblSubtitle.font = AppFonts.regular.with(size: 17)
        
        txtFldEmail.borderStyle = .none
        txtFldEmail.font = AppFonts.medium.with(size: 20)
        txtFldEmail.textColor = AppColors.textBlack
        txtFldEmail.text = ""
        
        txtFldPassword.borderStyle = .none
        txtFldPassword.font = AppFonts.medium.with(size: 20)
        txtFldPassword.textColor = AppColors.textBlack
        txtFldPassword.isSecureTextEntry = true
        txtFldPassword.text = ""
        txtFldEmail.delegate = self
        txtFldEmail.returnKeyType = .next
        txtFldPassword.delegate = self
        txtFldPassword.returnKeyType = .done
        txtFldEmail.tag = 0
        txtFldPassword.tag = 1
        
    }
    
    //MARK: -  action buttons
    
    @IBAction func actnBtnSignUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func actnBtnLogIn(_ sender: Any) {
        let email = txtFldEmail.text ?? ""
        let password = txtFldPassword.text ?? ""
       if let error = viewModel.validateLogin(email: email, password: password){
            showAlert(msg: error)
           return
        }
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        navigateToHome()
    }
    @IBAction func actnBtnBack(_ sender: Any) {
        backToPop()
    }
}
//MARK: -  text field delegates

extension SignInVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            let nextTag = textField.tag + 1
            if let nextField = view.viewWithTag(nextTag) as? UITextField {
                nextField.becomeFirstResponder()
            }else {
                
            }
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    func navigateToHome(){
        txtFldEmail.text = ""
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        navigationController?.setViewControllers([vc], animated: true)
    }
}
