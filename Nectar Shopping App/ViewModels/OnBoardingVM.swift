//
//  OnBoardingVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 29/05/26.
//

import Foundation
import UIKit

final class OnBoardingVM {
    private let onboarding = OnBoardingModel(
        backGroundImage: "onboardingBackgroundImage",
        logoImage: "LogoImages",
        btnTitle: "Get Started",
        title: "Welcome",
        title2 : "to our store",
        subtitle: "Get your groceries in as fast as 30 minutes" )
    
    var imageName : String {
        onboarding.backGroundImage
    }
    var logoImage : String {
        onboarding.logoImage
    }
    var btnTitle : String {
        onboarding.btnTitle
    }
    var title : String {
        onboarding.title
    }
    var title2 : String {
        onboarding.title2
    }
    var subtitle : String {
        onboarding.subtitle
    }
    
}

