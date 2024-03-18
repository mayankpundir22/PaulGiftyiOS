//
//  UIColor+Extensions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 12/03/24.
//

import UIKit


extension UIColor {
    class var appRoyalBlue: UIColor { return UIColor(named: "RoyalBlueColor")! }
    class var appMidnightBlue: UIColor { return UIColor(named: "MidnightBlueColor")! }
    
    class var appPeachOrange: UIColor { return UIColor(named: "PeachOrangeColor")! }
    class var appGoldenPeach: UIColor { return UIColor(named: "GoldenPeachColor")! }
    class var appGoldenrodBrown: UIColor { return UIColor(named: "GoldenrodBrownColor")! }
    
    class var appFireRed: UIColor { return UIColor(named: "FireRedColor")! }
    class var appRubyRed: UIColor { return UIColor(named: "RubyRedColor")! }
    
    class var appSoftPink: UIColor { return UIColor(named: "SoftPinkColor")! }
    class var appDustyRose: UIColor { return UIColor(named: "DustyRoseColor")! }
    
    class var appSilverGray: UIColor { return UIColor(named: "SilverGrayColor")! }

    static var randomColor: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}

extension UIColor {
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex     = String(rgba[index...]) //rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                    break
                }
            }
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
