//
//  LoginWithOTPViewModel.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import Foundation

class LoginWithOTPViewModel: BaseViewModel {
    var isOTPSent: Bool = false
    var otpCode: String?
    var phoneNumber: String?
    //binding to communicate with ViewController
    /*var onSendOTPClosure: CompletionVoid?
     var onOTPVerifyClosure: CompletionVoid?*/
    
    
    private func validPhoneNumber() -> String? {
        guard let phoneNo = phoneNumber?.trimmed,
              phoneNo.isNumeric,
              phoneNo.count == LimitCount.phoneNoDigitsCount  else {
            self.validationErrorMessage = AlertMessage.INVALID_PHONE_NUMBER
            return nil
        }
        return phoneNo
    }
    
    func sendOTPToPhoneNo() {
        guard let phoneNo = validPhoneNumber() else {
            return
        }
        isLoading = true
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            self?.isOTPSent = true
            self?.isLoading = false
            self?.validationErrorMessage = "OTP Sent"
            self?.reloadScreenUIClosure?()
        }
    }
    
    func verifyOTP(complition: @escaping CompletionBool) {
        guard let phoneNo = validPhoneNumber() else {
            return
        }
        guard let otp = otpCode?.trimmed, otp.isNumeric,
              otp.count == LimitCount.otpDigitsCount  else {
            self.validationErrorMessage = AlertMessage.INVALID_OTP
            return
        }
        isLoading = true
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            self?.isOTPSent = true
            self?.isLoading = false
            self?.validationErrorMessage = "OTP Verified"
            complition(true)
        }
    }
}
