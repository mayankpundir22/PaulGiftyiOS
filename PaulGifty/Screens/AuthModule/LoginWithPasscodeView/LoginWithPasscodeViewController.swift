//
//  LoginWithPasscodeViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 15/03/24.
//

import UIKit

class LoginWithPasscodeViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenDescLabel: UILabel!
    
    @IBOutlet weak var enterPasscodeLabel: UILabel!
    @IBOutlet weak var passcodeView: UIView!
    //@IBOutlet weak var passStackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    private var passcodeStackView: OTPStackView?
    private var loginPassTextTimer: Timer?
    
    private lazy var viewModel: LoginWithPasscodeViewModel = {
        let vwModel = LoginWithPasscodeViewModel()
        self.baseVwModel = vwModel
        return vwModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        initializeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    @IBAction func forgotButtonPressed(_ sender: Any) {
        showToast("Forgot Password Button Pressed")
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        resetTimer()
        loginUserWithPasscode()
    }
    
    
    private func setupLayout() {
        //passStackViewWidthConstraint.constant = view.frame.width * 0.918575
        if let bgColor = view.backgroundColor {
            mainView.backgroundColor = bgColor
        }
        screenTitleLabel.font = UIFont.gilroy(style: .semibold, size: 16)
        screenDescLabel.font = UIFont.gilroy(style: .regular, size: 12)
        enterPasscodeLabel.font = UIFont.gilroy(style: .regular, size: 13)
        
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        submitButton.titleLabel?.font = UIFont.gilroy(style: .bold, size: 12)
        forgotButton.titleLabel?.font = UIFont.gilroy(style: .regular, size: 13)
        
        passcodeStackView = OTPStackView(numberOfFields: LimitCount.passwordDigitsCount, setInView: passcodeView, isSecure: true)
        passcodeStackView?.delegate = self
        passcodeView.backgroundColor = .clear
    }
    
    private func initializeViewModel() {
        viewModel.reloadScreenUIClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.passcodeStackView?.emptyOTPTextFields()
                self?.showToast("Logged-In Successfully")
            }
        }
    }
}


//MARK: - OTPStackViewDelegate & Passcode Functionalities
extension LoginWithPasscodeViewController: OTPStackViewDelegate {
    
    func onOTPFieldCompleted(_ otpStackView: OTPStackView, otp: String) {
        resetTimer()
        loginPassTextTimer = Timer.scheduledTimer(
            timeInterval: LimitCount.serverHitTimerSeconds,
            target: self,
            selector: #selector(loginUserWithPasscode),
            userInfo: nil,
            repeats: false
        )
    }
    
    private func resetTimer() {
        loginPassTextTimer?.invalidate()
        loginPassTextTimer = nil
    }
    
    @objc private func loginUserWithPasscode() {
        guard let passcode = passcodeStackView?.getOTP() else {
            return
        }
        viewModel.loginWithPasscode(passcode)
    }
}
