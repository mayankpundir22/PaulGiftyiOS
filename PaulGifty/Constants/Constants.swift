//
//  Constants.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import Foundation


public enum AppPolicies: String {
    case privacyPolicy
    case termsAndConditions
    
    var title: String {
        switch self {
        case .privacyPolicy:
            return "Privacy Policy"
        case .termsAndConditions:
            return "Terms and Conditions"
        }
    }
    
    var url: String {
        switch self {
        case .privacyPolicy:
            return "https://policies.google.com/privacy"
        case .termsAndConditions:
            return "https://policies.google.com/terms"
        }
    }
}
