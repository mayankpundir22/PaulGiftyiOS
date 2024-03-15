//
//  LoginWithPasscodeViewModel.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 15/03/24.
//

import Foundation

class LoginWithPasscodeViewModel: BaseViewModel {    
    
    private func validPasscode(_ passcode: String?) -> String? {
        guard let _passcode = passcode?.trimmed, !_passcode.isEmpty else {
            self.validationErrorMessage = AlertMessage.EMPTY_PASSWORD
            return nil
        }
        if _passcode.count != LimitCount.passwordDigitsCount {
            self.validationErrorMessage = String(format: AlertMessage.INVALID_PASSWORD, LimitCount.passwordDigitsCount)
            return nil
        }
        return _passcode
    }
    
    func loginWithPasscode(_ passcode: String?) {
        guard let _passcode = validPasscode(passcode) else {
            return
        }
        isLoading = true
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            self?.isLoading = false
            self?.validationErrorMessage = "Logged-In Successfully"
            self?.reloadScreenUIClosure?()
        }
    }
}
