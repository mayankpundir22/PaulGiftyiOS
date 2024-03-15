//
//  GeneratePasswordViewModel.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 14/03/24.
//

import Foundation

class GeneratePasswordViewModel: BaseViewModel {
    var newPasscode: String?
    var confirmPasscode: String?
    
    private func validatePasscode() -> Bool {
        guard let newPass = newPasscode?.trimmed, !newPass.isEmpty else {
            self.validationErrorMessage = AlertMessage.NEW_PASSWORD
            return false
        }
        if newPass.count != LimitCount.passwordDigitsCount {
            self.validationErrorMessage = String(format: AlertMessage.INVALID_PASSWORD, LimitCount.cardKitNoDigitsCount)
            return false
        }
        guard let confirmPass = confirmPasscode?.trimmed, !confirmPass.isEmpty else {
            self.validationErrorMessage = AlertMessage.CONFIRM_PASSWORD
            return false
        }
        if newPass != confirmPass {
            self.validationErrorMessage = AlertMessage.MISMATCH_PASSWORD
            return false
        }
        newPasscode = newPass
        confirmPasscode = confirmPass
        return true
    }
    
    func createPasscode() {
        guard validatePasscode() else {
            return
        }
        isLoading = true
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            self?.isLoading = false
            self?.validationErrorMessage = "Your password has been successfully created"
            self?.reloadScreenUIClosure?()
        }
    }
}
