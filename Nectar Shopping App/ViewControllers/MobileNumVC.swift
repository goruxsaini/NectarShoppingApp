//
//  MobileNumVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 31/05/26.
//

import UIKit

class MobileNumVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var lblTitle1 : UILabel!
    @IBOutlet weak var lblTitle2 : UILabel!
    @IBOutlet weak var txtFldNumber : UITextField!
    @IBOutlet weak var btnNext : UIButton!
    @IBOutlet weak var btnNextBottomConstraints: NSLayoutConstraint!
    
    
    var viewModel = MobileNumVM()
    
    //MARK:  view Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(named:"AppBackground")
        setUpUI()
        dismissKeyboardOntap()
        self.navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("keyboard")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - functions
    //Keyboard hide show functionality
    @objc private func keyboardWillShow(_ notification : Notification){
        // here this things stores the additional data which comes from keyboardwillshownotification.
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        print("Keyboard Appeared")
        btnNextBottomConstraints.constant = -(keyboardFrame.height - 20)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    // Gain the original position of button
    @objc private func keyboardWillHide(_ notification : Notification){
       
        print("KeyBoard Hidden")
        btnNextBottomConstraints.constant = -40
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)

    }
    private func setUpUI(){
        lblTitle1.text = "Enter your mobile number"
        lblTitle1.font = AppFonts.semibold.with(size: 25)
        lblTitle1.textColor = AppColors.textBlack
        
        lblTitle2.text = "Mobile Number"
        lblTitle2.font = AppFonts.medium.with(size: 18)
        lblTitle2.textColor = AppColors.textGray
        
        txtFldNumber.font = AppFonts.medium.with(size: 17)
        txtFldNumber.textColor = AppColors.textBlack
        txtFldNumber.returnKeyType = .done
        txtFldNumber.borderStyle = .none
        txtFldNumber.keyboardType = .numberPad
        
        txtFldNumber.delegate = self
        
        btnNext.alpha = 0.5
        btnNext.isEnabled = false
        
        btnNext.configureBtn(title: nil,
                             font: nil,
                             bgClr: .primaryGreen,
                             tint: .white,
                             cornerRadius: 35,
                             border: 0,
                             borderColor: AppColors.textBlack)
        btnNext.tintColor = AppColors.textWhite
    }
    @IBAction func actnBtnNext(_ sender: Any) {
        guard let phoneNum = txtFldNumber.text else { return }
        
        if viewModel.isValidPhnNumber(phoneNum){
            print("Navigate")
            navigateToOtp()
        }else {
            print("Invalid")
            showAlert()
        }
    }
    @IBAction func actbBtnBack(_ sender: Any) {
        backToPop()
    }
    @IBAction func textFieldAction(_ sender: UITextField) {
        let phone = sender.text ?? ""
        
        let isValid = viewModel.isValidPhnNumber(phone)
        btnNext.isEnabled = isValid
        btnNext.alpha = isValid ? 1 : 0.5
        
    }
}
extension MobileNumVC {
    
    private func navigateToOtp(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func showAlert(){
        let alert = UIAlertController(title: "Invalid Number", message: "Please enter a 10 digit valid mobile number", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
extension MobileNumVC : UITextFieldDelegate {
     func textField(_ textField: UITextField, shouldChangeCharactersIn ranges: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        let updatedText = (currentText as NSString).replacingCharacters(in: ranges, with: string)
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacters.isSuperset(of: characterSet)
        
        return isNumber && updatedText.count <= 10
    }
}
