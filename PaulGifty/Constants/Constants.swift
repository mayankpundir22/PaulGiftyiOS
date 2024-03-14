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


struct LimitCount {
    static let otpDigitsCount: Int      = 6
    static let phoneNoDigitsCount: Int  = 10
    static let maxDecimalPlaces: Int    = 2
    static let maxOTPResendSeconds: Int = 60
}


struct ValidationRegex {
    static let email : String               = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let password : String            = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#@!$"
}


public struct DateFormats {
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
