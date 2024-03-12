//
//  LaunchAnimationViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 12/03/24.
//

import UIKit

class LaunchAnimationViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    private let animationDuration: TimeInterval = 1.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLogoAnimation()
    }
    
    private func startLogoAnimation() {
        UIView.animate(withDuration: animationDuration) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
            //After animation completed - Start App Flow
            SceneDelegate.sceneDelegate?.updateRootController()
        }
    }
}
