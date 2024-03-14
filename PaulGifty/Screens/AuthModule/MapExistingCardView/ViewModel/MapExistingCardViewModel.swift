//
//  MapExistingCardViewModel.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 14/03/24.
//

import Foundation

class MapExistingCardViewModel: BaseViewModel {
    var cardHolderName: String?
    var cardKitNumber: String?
    var cardNumber: String?
    
    
    private func validateData() -> Bool {
        guard let name = self.cardHolderName?.trimmed, !name.isEmpty else {
            self.validationErrorMessage = AlertMessage.INVALID_NAME
            return false
        }
        guard let cardNo = self.cardNumber?.trimmed,
              cardNo.count == LimitCount.maxCardDigitsAllowed else {
            
            let message = String(format: AlertMessage.INVALID_CARD_LAST_DIGITS, LimitCount.maxCardDigitsAllowed)
            self.validationErrorMessage = message
            return false
        }
        guard let kitNo = self.cardKitNumber?.trimmed, !kitNo.isEmpty else {
            self.validationErrorMessage = AlertMessage.INVALID_CARD_KIT_NO
            return false
        }
        if kitNo.count != LimitCount.cardKitNoDigitsCount {
            let message = String(format: AlertMessage.INCOMPLETE_CARD_KIT_NUMBER, LimitCount.cardKitNoDigitsCount)
            self.validationErrorMessage = message
            return false
        }
        self.cardHolderName = name
        self.cardKitNumber = kitNo
        self.cardNumber = cardNo
        return true
    }
    
    func startMappingCardWithPhoneNumber() {
        guard validateData() else {
            return
        }
        isLoading = true
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            self?.isLoading = false
            self?.validationErrorMessage = "Card Mapped With Phone Number"
            self?.reloadScreenUIClosure?()
        }
    }
}
