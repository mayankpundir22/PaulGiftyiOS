//
//  UIApplication+Extensions.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit


extension UIApplication {
    
    class var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
        
    }
    
    class func topViewController(_ controller: UIViewController? = firstKeyWindow?.rootViewController) -> UIViewController? {
        
        if let navController = controller as? UINavigationController {
            return topViewController(navController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }
        return controller
    }
}
