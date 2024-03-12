//
//  AppInstance.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 12/03/24.
//

import Foundation


class AppInstance: NSObject {

    static let shared = AppInstance()
    
    var isShowLaunchAnimation: Bool = false
    
    
    override private init() {
        super.init()
    }
}
