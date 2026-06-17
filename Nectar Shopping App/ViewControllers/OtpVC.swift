//
//  OtpVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 03/06/26.
//

import UIKit

class OtpVC: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var btnNextBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var txtFldOtp: UITextField!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnResendCode: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    
    var viewModel = OtpVM()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupUI()
        setBackgroundImage(named: "AppBackground")
        dismissKeyboardOntap()
        txtFldOtp.delegate = self
    }
    //MARK: - Keyboard Uplifting feature
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification : Notification){
        guard let keyboardframe = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        btnNextBottomConstraints.constant = (keyboardframe.height + 20)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide(_ notification : Notification){
        btnNextBottomConstraints.constant = 40
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: - Functions
    private func setupUI(){
        lblTitle.text = "Enter your 4-digit code"
        lblTitle.font = AppFonts.semibold.with(size: 25)
        lblTitle.textColor = AppColors.textBlack
        
        lblSubtitle.text = "Code"
        lblSubtitle.font = AppFonts.semibold.with(size: 17)
        lblSubtitle.textColor = AppColors.textGray
        
        txtFldOtp.placeholder = " - - - - "
        txtFldOtp.keyboardType = .numberPad
        txtFldOtp.font = AppFonts.medium.with(size: 17)
        txtFldOtp.textColor = AppColors.textBlack
        
        btnResendCode.tintColor = AppColors.primaryGreen
        btnResendCode.titleLabel?.font = AppFonts.medium.with(size: 17)
        
        btnNext.configureBtn(title: nil, font: nil, bgClr: .primaryGreen, tint: .white, cornerRadius: 35,border: 0,borderColor: AppColors.textBlack)
        btnNext.tintColor = AppColors.textWhite
        btnNext.alpha = 0.5
        btnNext.isEnabled = true
    }
    //MARK: - Actions
    @IBAction func actnBtnNext(_ sender: Any) {
        guard let Otp = txtFldOtp.text else {return}
        
        if viewModel.isOTPValid(Otp){
            navigation()
        }else {
            showAlert()
        }
    }
    @IBAction func actnTxtFld(_ sender: UITextField) {
        let otp = sender.text ?? ""
        let isValid = viewModel.isOTPValid(otp)
        btnNext.isEnabled = isValid
        btnNext.alpha = isValid ? 1 : 0.5
    }
    @IBAction func actnBtnBack(_ sender: UIButton) {
        backToPop()
    }
}
extension OtpVC{
    private func navigation(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Invalid OTP", message: "Please enter the correct otp", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
    }
}
extension OtpVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn ranges: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: ranges, with: string)
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacters.isSuperset(of: characterSet)
        return isNumber && updatedText.count <= 4
    }
}
