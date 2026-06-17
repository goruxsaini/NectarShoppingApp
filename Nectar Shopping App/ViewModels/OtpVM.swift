//
//  OtpVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 04/06/26.
//

import Foundation
final class OtpVM {
    func isOTPValid(_ otp : String) -> Bool {
        let savedOTP = "4576"
        return otp.count == 4 && otp == savedOTP
    }
}
