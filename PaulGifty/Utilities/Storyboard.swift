//
//  Storyboard.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 16/03/24.
//

import UIKit


enum Storyboard: String {
    case Auth
    case Home
    case Other
}


extension Storyboard {

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateVC<T: UIViewController>(type: T.Type) -> T? {
        return instance.instantiateViewController(withIdentifier: type.className) as? T
    }
}
