//
//  SignUpVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 13/06/26.
//

import Foundation
final class SignUpVM {
    func validateSignUp(username : String,email : String, password : String)-> String? {
        if username.count < 3 {
            return StaticMessages.invalidUsername
        }
        if !validateEmail(email){
            return  StaticMessages.invalidEmail
        }
        if password.count < 8 {
            return StaticMessages.invalidPassword
        }
        return nil
    }
    func validateEmail ( _ email : String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}
