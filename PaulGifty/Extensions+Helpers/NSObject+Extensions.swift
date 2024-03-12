//
//  NSObject+Extensions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 11/03/24.
//

import Foundation


extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
