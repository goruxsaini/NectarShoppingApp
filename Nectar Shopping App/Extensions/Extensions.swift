//
//  BackgroundImage.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 30/05/26.
//

import Foundation
import UIKit
//MARK: - Set Background Image
extension UIViewController {
    func setBackgroundImage(named imageName : String) {
        let backgroundImage = UIImageView(frame: view.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.clipsToBounds = true
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(backgroundImage, at: 0)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
//MARK: - Configure Button
extension UIButton {
    func configureBtn(title:String?,font: UIFont?,bgClr:UIColor?,tint:UIColor?,cornerRadius: CGFloat = 15,border : CGFloat,borderColor: UIColor?)
    {
        self.layer.cornerRadius = cornerRadius
        self.setTitle(title, for: .normal)
        self.setTitleColor(tint, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = bgClr
        self.layer.borderWidth = border
        self.layer.borderColor = borderColor?.cgColor
    }
}
//MARK: - Dismiss Keyboard on Tap
extension UIViewController{
    func dismissKeyboardOntap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc private func dissmissKeyboard(){
        view.endEditing(true)
    }
}
//MARK: - Show Custom ALert
extension UIViewController{
    func showAlert(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        }
}
//MARK: - back Button "Pop"
extension UIViewController {
    func backToPop(animated : Bool = true){
        self.navigationController?.popViewController(animated: animated)
    }
}
