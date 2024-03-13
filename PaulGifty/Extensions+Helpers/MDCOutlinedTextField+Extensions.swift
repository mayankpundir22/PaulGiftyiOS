//
//  MDCOutlinedTextField+Extensions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import MaterialComponents


extension MDCOutlinedTextField {
    
    func applyAppThemeStyle() {
        //self.containerRadius = 20
        self.setOutlineColor(UIColor.appRoyalBlue, for: .normal)
        self.setOutlineColor(UIColor.appRoyalBlue, for: .editing)
        self.setTextColor(UIColor.appRoyalBlue, for: .normal)
        self.setTextColor(UIColor.appRoyalBlue, for: .editing)
        self.setFloatingLabelColor(UIColor.appRoyalBlue, for: .normal)
        self.setFloatingLabelColor(UIColor.appRoyalBlue, for: .editing)
        self.setNormalLabelColor(UIColor.appRoyalBlue, for: .normal)
        self.setNormalLabelColor(UIColor.appRoyalBlue, for: .editing)
       /* if let text = self.label.text {
            self.label.text = "    \(text)"
        }*/
    }
}
