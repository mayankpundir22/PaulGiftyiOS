//
//  LoadingViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenDescLabel: UILabel!
    
    @IBOutlet weak var loadingImageStack: UIStackView!
    @IBOutlet weak var centerLoadingView: UIView!
    
    @IBOutlet weak var factsDescLabel: UILabel!
    @IBOutlet weak var factsTitleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }
    
    
    private func setupLayout() {
        centerLoadingView.isHidden = false
        centerLoadingView.backgroundColor = (view.backgroundColor ?? .white).withAlphaComponent(0.999999)
        loadingImageStack.animateWithLinearMotion(isInLoop: false)
    }
}
