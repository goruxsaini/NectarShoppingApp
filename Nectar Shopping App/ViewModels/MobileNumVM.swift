//
//  MobileNumVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 03/06/26.
//

import Foundation

final class MobileNumVM {
    func isValidPhnNumber(_ phoneNumber : String) -> Bool{
        let savedNumber = "1234567890"
        return phoneNumber.count == 10 && phoneNumber == savedNumber
    }
}
