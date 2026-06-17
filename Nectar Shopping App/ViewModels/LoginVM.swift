//
//  LoginVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 08/06/26.
//

import Foundation


// returns "true" if both email and password are filled and return "False" if one id filled and another is not.
final class LoginVM {
    func validateLogin(email:String,password:String) -> String? {
        //Fetch Saved Values from User Defaults.
        let savedEmail = UserDefaults.standard.string(forKey: "userEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword")
        if email != savedEmail {
            return StaticMessages.invalidEmail
        }
        if password != savedPassword {
            return  StaticMessages.invalidPassword
        }
        return nil
    }
}
