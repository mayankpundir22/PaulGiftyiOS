//
//  Utility.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 16/03/24.
//

import UIKit

class Utility: NSObject {
    
    static func openExternalLink(_ urlString: String, completion: CompletionBool? = nil) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            completion?(false)
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    static func openAppSettings(completion: CompletionBool? = nil) {
        openExternalLink(UIApplication.openSettingsURLString, completion: completion)
    }
    
    static func phoneNumberEndingDigits(_ phoneNumber: String?) -> String? {
        guard let phoneNo = phoneNumber?.trimmed,
              phoneNo.isNumeric,
              phoneNo.count >= LimitCount.phoneNoLengthToShow  else {
            return nil
        }
        let startIndex = phoneNo.index(phoneNo.endIndex, offsetBy: -4)
        let lastDigits = phoneNo[startIndex...]
        return String(lastDigits)
    }
    
    static func securePhoneNumber(_ phoneNumber: String?) -> String {
        guard let phoneNo = Utility.phoneNumberEndingDigits(phoneNumber) else {
            return "****"
        }
        return "***\(phoneNo)"
    }
}
