//
//  LoginWithOTPViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 12/03/24.
//

import UIKit
import MaterialComponents

class LoginWithOTPViewController: UIViewController {
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenDescLabel: UILabel!
    @IBOutlet weak var phoneNoTextField: MDCOutlinedTextField!
    @IBOutlet weak var policyCheckBox: CheckboxButton!
    @IBOutlet weak var policyTextView: UITextView!
    @IBOutlet weak var getOTPButton: UIButton!
    
    //private var isLayoutAdjusted: Bool = false
    /*override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !isLayoutAdjusted {
            isLayoutAdjusted.toggle()
            //phoneNoTextField.containerRadius = 16
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupLayout() {
        phoneNoTextField.label.text = "Enter Phone number here"
        phoneNoTextField.placeholder = "+91 9876543210"
        phoneNoTextField.applyAppThemeStyle()
        configurePolicyTextView()
    }
    
    private func configurePolicyTextView() {
        let attributedText = NSMutableAttributedString(string: Strings.accountCreationPolicy)
        // Find ranges for Privacy Policy and Terms and Conditions
        let privacyRange = (Strings.accountCreationPolicy as NSString).range(of: AppPolicies.privacyPolicy.title)
        let termsRange = (Strings.accountCreationPolicy as NSString).range(of: AppPolicies.termsAndConditions.title)
        
        // Add attributes for links and underline remaining text
        attributedText.addAttributes([
            .link: AppPolicies.privacyPolicy.url,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.appRoyalBlue,
            //.underlineColor: UIColor.appRoyalBlue
        ], range: privacyRange)
        
        attributedText.addAttributes([
            .link: AppPolicies.termsAndConditions.url,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.appRoyalBlue,
            //.underlineColor: UIColor.appRoyalBlue
        ], range: termsRange)
        
        policyTextView.attributedText = attributedText
        policyTextView.textColor = .appRoyalBlue
        // Set delegate to handle link clicks
        policyTextView.delegate = self
    }
}


//MARK: UITextViewDelegate
extension LoginWithOTPViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        UIApplication.shared.open(URL)
        // Prevent default behavior
        return false
    }
}
