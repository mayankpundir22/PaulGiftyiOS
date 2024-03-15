//
//  Strings.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import Foundation


public struct Strings {
    static let am                           = "AM"
    static let pm                           = "PM"
    
    static let paulGifty                    = "Paul Gifty"
    static let accountCreationPolicy        = "By creating the account, I accept to the Privacy Policy & Terms and Conditions."
}


//MARK: Alert Messages
public struct AlertMessage {
    static let INVALID_VALUE                = "Please enter valid value."
    static let INVALID_NAME                 = "Please enter your full name."
    static let EMPTY_IMAGE_FIELD            = "Please select an image."
    static let INVALID_FIRST_NAME           = "Please enter first name."
    static let INVALID_LAST_NAME            = "Please enter last name."
    static let INVALID_GENDER               = "Please select Gender."
    static let INVALID_DOB                  = "Please select date of birth."
    static let EMPTY_EMAIL                  = "Please enter an email address"
    static let INVALID_EMAIL                = "Please enter a valid email address."
    static let INVALID_PHONE_NUMBER         = "Please enter a valid phone number."
    static let INVALID_CARD_LAST_DIGITS     = "Please enter card's last %d digits."
    static let INVALID_CARD_KIT_NO          = "Please enter valid card KIT number."
    static let INVALID_SELECTION            = "Kindly choose one option from the available choices."
    static let INCOMPLETE_CARD_KIT_NUMBER   = "Your card kit number appears incomplete. Please enter all %d digits."
    
    static let INVALID_PASSWORD             = "Please enter a minimum %d character passcode"
    static let OLD_PASSWORD                 = "Please enter old passcode"
    static let NEW_PASSWORD                 = "Please enter new passcode"
    static let CONFIRM_PASSWORD             = "Please enter confirm passcode"
    static let MISMATCH_PASSWORD            = "Passcode doesn't match with Confirm Passcode"
    
    static let MISSING_OTP                  = "Please enter the OTP and then continue.."
    static let INVALID_OTP                  = "Invalid OTP. Please try again."
    static let WRONG_OTP                    = "Incorrect OTP. Please try again."
    
    static let UNKNOWN_AUTHORIZATION        = "Unknown authorization status."
    static let DEVICE_NOT_SUPPORT_CALL      = "Phone call not available on this device."
    static let DEVICE_NOT_SUPPORT_EMAIL     = "Email service is not available on this device."
    
    static let PHONE_OTP_VERIFICATION       = "We’ve sent a OTP to your registered number ending with %@. Please enter the OTP to complete phone verification."
    static let PHONE_OTP_RESEND             = "We’ve sent a new OTP to your registered number ending with %@. Please enter new OTP to complete the phone verification."
    
    static let EMAIL_FAILED                 = "Email sending failed."
    static let EMAIL_CANCELLED              = "Email cancelled."
    static let EMAIL_SAVED                  = "Email saved as a draft."
    static let EMAIL_SENT                   = "Email sent successfully."
    static let PASS_RESET_EMAIL_SENT        = "Password reset email sent successfully"
    static let PROFILE_UPDATED              = "Your profile updated successfully."
    static let ACCEPT_POLICY_AND_TERMS      = "To use our service, you must agree to the Privacy Policy and Terms & Conditions."
    
    static let LOGOUT                       = "Do you want to logout?"
    static let UNKNOWN_ERROR                = "Something went wrong, please try again later."
    static let SERVER_NOT_RESPONDING        = "We are facing some issue. Please try after some time."
}
