//
//  Fonts.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 29/05/26.
//

import Foundation

import UIKit

private let brandFontName = "Gilroy"

enum AppFonts {
    case regular
    case heavy
    case light
    case medium
    case bold
    case semibold
    
    var title : String {
        switch self {
            
        case .regular:
            return "\(brandFontName)-Regular"
        case .bold :
            return "\(brandFontName)-Bold"
        case .heavy :
            return "\(brandFontName)-Heavy"
        case .light :
            return "\(brandFontName)-Light"
        case .medium :
            return "\(brandFontName)-Medium"
        case .semibold :
            return "\(brandFontName)-SemiBold"
        }
    }
    func with(size: CGFloat) -> UIFont {
        UIFont(name: title, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

