//
//  UIView+Extensions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit


extension UIView {
    
    func animateWithLinearMotion(withDuration: TimeInterval = 3, translationX: CGFloat = -180, isInLoop: Bool = false) {
        UIView.animate(withDuration: withDuration, delay: 0, options: .curveLinear, animations: { [weak self] in
            self?.transform = CGAffineTransform(translationX: translationX, y: 0)
        }) { [weak self] (success: Bool) in
            self?.transform = CGAffineTransform.identity
            if isInLoop {
                self?.animateWithLinearMotion(withDuration: withDuration, translationX: translationX, isInLoop: isInLoop)
            }
        }
    }
}
