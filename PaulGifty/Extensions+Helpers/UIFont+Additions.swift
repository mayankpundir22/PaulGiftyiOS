//
//  UIFont+Additions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 12/03/24.
//

import UIKit


enum FontStyle: String {
    case thin = "Thin"
    case light = "Light"
    case regularItalic = "RegularItalic"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case semiboldItalic = "SemiBoldItalic"
    case bold = "Bold"
}


extension UIFont {
    
    static func fontWith(name:String , ofSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: ofSize) else {
            return UIFont.systemFont(ofSize: ofSize)
        }
        return font
    }
    
    //MARK: Gilroy
    static func gilroy(style: FontStyle, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gilroy-\(style.rawValue)", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
