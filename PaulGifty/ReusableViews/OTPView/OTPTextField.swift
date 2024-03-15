//
//  OTPTextField.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 15/03/24.
//

import UIKit

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }
    
}
