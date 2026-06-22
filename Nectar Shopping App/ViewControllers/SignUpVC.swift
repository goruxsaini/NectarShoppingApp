//
//  SignUpVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 09/06/26.
//

import UIKit

class SignUpVC: UIViewController {
//MARK: - Outlets
    
    @IBOutlet weak var imgVwLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldUsername: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    //MARK: - Properties
    private let viewModel = SignUpVM()
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setBackgroundImage(named:"AppBackground")
        dismissKeyboardOntap()
        txtFldUsername.tag = 0
        txtFldEmail.tag = 1
        txtFldPassword.tag = 2
    }
    //MARK: - Functions
    private func setUpUI(){
        imgVwLogo.image = UIImage(named: "AppLogoColored")
        imgVwLogo.contentMode = .scaleAspectFit
        
        lblTitle.text = "Sign Up"
        lblTitle.font = AppFonts.semibold.with(size: 30)
        lblTitle.textColor = AppColors.textBlack
        
        lblSubtitle.text = "Enter your credentials to continue"
        lblSubtitle.font = AppFonts.regular.with(size: 17)
        lblSubtitle.textColor = AppColors.textGray
        
        btnSignUp.configureBtn(title: "Sign Up", font: AppFonts.semibold.with(size: 20), bgClr: .primaryGreen, tint: .white, border: 1, borderColor: .textBlack)
        
        txtFldUsername.delegate = self
        txtFldUsername.borderStyle = .none
        txtFldUsername.font = AppFonts.medium.with(size: 17)
        txtFldUsername.textColor = AppColors.textBlack
        txtFldUsername.returnKeyType = .next
        
        txtFldPassword.delegate = self
        txtFldPassword.borderStyle = .none
        txtFldPassword.font = AppFonts.medium.with(size: 17)
        txtFldPassword.textColor = AppColors.textBlack
        txtFldPassword.returnKeyType = .done
        
        txtFldEmail.delegate = self
        txtFldEmail.borderStyle = .none
        txtFldEmail.font = AppFonts.medium.with(size: 17)
        txtFldEmail.textColor = AppColors.textBlack
        txtFldEmail.returnKeyType = .next
    }
    //MARK: - Actions
    @IBAction func actnBtnSignUp(_ sender: Any) {
        let username = txtFldUsername.text ?? ""
        let email = txtFldEmail.text ?? ""
        let password = txtFldPassword.text ?? ""
        if let error = viewModel.validateSignUp(username: username, email: email, password: password) {
            showAlert(msg: error)
            return
        }
        backToPop() 
        UserDefaults.standard.set(username, forKey: "userName")
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        
    }
    @IBAction func actnBtnSignIn(_ sender: Any) {
        backToPop()
    }
    @IBAction func actnBtnBack(_ sender: Any) {
        backToPop()
    }
}
//MARK: - Text Field Delegate
extension SignUpVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            let nextTag = textField.tag + 1
            if let nextField = view.viewWithTag(nextTag) as? UITextField {
                nextField.becomeFirstResponder()
            }else {
                
            }
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    func navigateToLogin(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        navigationController?.pushViewController(vc, animated: true)
        print("navigation")
    }
}
