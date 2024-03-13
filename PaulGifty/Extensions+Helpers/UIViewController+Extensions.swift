//
//  UIViewController+Extensions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit


extension UIViewController {
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissOpenedKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissOpenedKeyboard() {
        view.endEditing(true)
    }
}
