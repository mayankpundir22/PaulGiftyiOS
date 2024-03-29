//
//  Constants.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import Foundation


typealias CompletionVoid                    = () -> Void
typealias CompletionError                   = (_ error: Error?) -> Void
typealias CompletionURL                     = (_ url: URL?) -> Void
typealias CompletionBool                    = (_ isSuccess: Bool) -> Void
typealias CompletionString                  = (_ value: String?) -> Void
typealias CompletionStringResult            = (Result<String?, NSError>) -> Void
typealias CompletionURLResult               = (Result<URL?, NSError>) -> Void


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

public enum MenuOption: String {
    case notifications
    case transactions
    case frequentlyAskedQuestions
    case termsAndConditions
    case privacyPolicy
    case grievancePolicy
    
    var title: String {
        switch self {
        case .notifications:
            return "Notifications"
        case .transactions:
            return "Transactions"
        case .frequentlyAskedQuestions:
            return "Frequently Asked Questions"
        case .termsAndConditions:
            return "Terms & Conditions"
        case .privacyPolicy:
            return "Privacy Policy"
        case .grievancePolicy:
            return "Grievance Policy"
        }
    }
    
    var icon: String {
        switch self {
        case .notifications:
            return "bell-icon-golden"
        case .transactions:
            return "transaction-icon-golden"
        case .frequentlyAskedQuestions:
            return "faq-icon-golden"
        case .termsAndConditions:
            return "terms-icon-golden"
        case .privacyPolicy:
            return "policy-icon-golden"
        case .grievancePolicy:
            return "policy-icon-golden"
        }
    }
}


struct LimitCount {
    static let otpDigitsCount: Int          = 6
    static let passwordDigitsCount: Int     = 6
    static let phoneNoLengthToShow: Int     = 5
    static let phoneNoDigitsCount: Int      = 10
    static let cardKitNoDigitsCount: Int    = 16
    static let maxCardDigitsAllowed: Int    = 4
    static let maxDecimalPlaces: Int        = 2
    static let maxOTPResendSeconds: Int     = 60
    static let serverHitTimerSeconds: TimeInterval = 2
}

struct ValidationRegex {
    static let email : String               = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let password : String            = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#@!$"
}

struct DateFormats {
    static let mm_ss                        = "mm:ss"
    static let hh_mm_a                      = "hh:mm a"
    static let hh_mm_ss_a                   = "hh:mm:ss a"
    static let dd_MM_yy                     = "dd/MM/yy"
    static let dd_MM_yyyy                   = "dd/MM/yyyy"
    static let MM_dd_yyyy                   = "MM/dd/yyyy"
    static let yyyy_MM_dd                   = "yyyy-MM-dd"
    static let d_M_yy_h_mm_a                = "d/M/yy, h:mm a"
    static let MM_dd_yyyy_hh_mm_a           = "MM/dd/yyyy hh:mm a"
    static let MMM_dd_yyyy_HH_mm            = "MMM dd, yyyy HH:mm"
    static let MMM_dd_yyyy_hh_mm_a          = "MMM dd, yyyy hh:mm a"
    static let yyyy_MM_dd_HH_mm_ss_SSSZ     = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

struct AppSupport {
    static let phoneNumber                  = "18001371333"
    static let privacyPolicyURL             = "https://api.magicalvacation.com/giftyapp/api/user/privacy-policy"
    static let grievancePolicyURL           = "https://api.magicalvacation.com/giftyapp/api/user/policy"
    static let termsAndConditionsURL        = "https://api.magicalvacation.com/giftyapp/api/user/terms-conditions"
}
