//
//  GeneratePasswordViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 14/03/24.
//

import UIKit

class GeneratePasswordViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenDescLabel: UILabel!
    
    @IBOutlet weak var createPasscodeLabel: UILabel!
    @IBOutlet weak var createPasscodeView: UIView!
    @IBOutlet weak var confirmPasscodeLabel: UILabel!
    @IBOutlet weak var confirmPasscodeView: UIView!
    
    @IBOutlet weak var passcodeMessageLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    private var createPasscodeStackView: OTPStackView?
    private var confirmPasscodeStackView: OTPStackView?
    
    private lazy var viewModel: GeneratePasswordViewModel = {
        let vwModel = GeneratePasswordViewModel()
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
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        viewModel.newPasscode = createPasscodeStackView?.getOTP()
        viewModel.confirmPasscode = confirmPasscodeStackView?.getOTP()
        viewModel.createPasscode()
    }
    
    
    private func setupLayout() {
        if let bgColor = view.backgroundColor {
            mainView.backgroundColor = bgColor
        }
        screenTitleLabel.font = UIFont.gilroy(style: .semibold, size: 16)
        screenDescLabel.font = UIFont.gilroy(style: .regular, size: 12)
        
        createPasscodeLabel.font = UIFont.gilroy(style: .regular, size: 13)
        confirmPasscodeLabel.font = UIFont.gilroy(style: .regular, size: 13)
        passcodeMessageLabel.font = UIFont.gilroy(style: .regular, size: 11)
        
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        submitButton.titleLabel?.font = UIFont.gilroy(style: .bold, size: 12)
        
        createPasscodeStackView = OTPStackView(numberOfFields: LimitCount.passwordDigitsCount, setInView: createPasscodeView, isSecure: true)
        confirmPasscodeStackView = OTPStackView(numberOfFields: LimitCount.passwordDigitsCount, setInView: confirmPasscodeView, isSecure: true)
        createPasscodeStackView?.delegate = self
        confirmPasscodeStackView?.delegate = self
        createPasscodeView.backgroundColor = .clear
        confirmPasscodeView.backgroundColor = .clear
    }
    
    private func initializeViewModel() {
        viewModel.reloadScreenUIClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.createPasscodeStackView?.emptyOTPTextFields()
                self?.confirmPasscodeStackView?.emptyOTPTextFields()
            }
        }
    }
}


//MARK: - OTPStackViewDelegate
extension GeneratePasswordViewController: OTPStackViewDelegate {
    
    func onOTPFieldCompleted(_ otpStackView: OTPStackView, otp: String) {
        switch otpStackView {
        case createPasscodeStackView:
            viewModel.newPasscode = otp
            break
        case confirmPasscodeStackView:
            viewModel.confirmPasscode = otp
            break
        default: break
        }
    }
}
