//
//  LoginWithOTPViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 12/03/24.
//

import UIKit
import MaterialComponents

class LoginWithOTPViewController: BaseViewController {
        
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenDescLabel: UILabel!
    @IBOutlet weak var phoneNoTextField: MDCOutlinedTextField!
    //Policy Views
    @IBOutlet weak var policyStackView: UIStackView!
    @IBOutlet weak var policyCheckBox: CheckboxButton!
    @IBOutlet weak var policyTextView: UITextView!
    //OTP Realted Views
    @IBOutlet weak var otpStackView: UIStackView!
    @IBOutlet weak var otpTextField: MDCOutlinedTextField!
    @IBOutlet weak var otpResendMsgLabel: UILabel!
    @IBOutlet weak var otpResendButton: UIButton!
    @IBOutlet weak var otpResendTimeLabel: UILabel!
    //Submit Button
    @IBOutlet weak var submitButton: UIButton!
    
    private var timer: Timer?
    private var timerSeconds: Int = 0
    
    private lazy var viewModel: LoginWithOTPViewModel = {
        let vwModel = LoginWithOTPViewModel()
        self.baseVwModel = vwModel
        return vwModel
    }()
    //private var isLayoutAdjusted: Bool = false
    /*override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !isLayoutAdjusted {
            isLayoutAdjusted.toggle()
            mainView.roundCorners([.topLeft, .topRight], radius: 30)
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        updateScreenUI()
        initializeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    /*override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Release Resources
        invalidateOTPTimer()
    }*/
    
    @IBAction func otpResendButtonPressed(_ sender: Any) {
        viewModel.sendOTPToPhoneNo()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if viewModel.isOTPSent {
            verifyOTP()
            return
        }
        guard policyCheckBox.isChecked else {
            showToast(AlertMessage.ACCEPT_POLICY_AND_TERMS)
            //UIAlertController.showAlert(self, message: AlertMessage.ACCEPT_POLICY_AND_TERMS)
            return
        }
        viewModel.sendOTPToPhoneNo()
    }
    
    
    private func setupLayout() {
        if let bgColor = view.backgroundColor {
            mainView.backgroundColor = bgColor
        }
        phoneNoTextField.delegate = self
        otpTextField.delegate = self
        viewModel.isOTPSent = false
        screenTitleLabel.font = UIFont.gilroy(style: .semibold, size: 16)
        screenDescLabel.font = UIFont.gilroy(style: .regular, size: 12)
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        submitButton.titleLabel?.font = UIFont.gilroy(style: .bold, size: 12)
        
        otpResendMsgLabel.font = UIFont.gilroy(style: .regular, size: 12)
        otpResendTimeLabel.font = UIFont.gilroy(style: .regular, size: 12)
        otpResendButton.titleLabel?.font = UIFont.gilroy(style: .regular, size: 12)
        
        let phoneTFLeftView = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: phoneNoTextField.frame.height * 0.8))
        phoneTFLeftView.font = UIFont.gilroy(style: .regular, size: 16)
        phoneTFLeftView.backgroundColor = .clear
        phoneTFLeftView.text = "+91"
        phoneTFLeftView.textColor = .appRoyalBlue
        phoneNoTextField.leadingView = phoneTFLeftView
        phoneNoTextField.leadingViewMode = .always

        phoneNoTextField.label.text = "Enter Phone number here"
        phoneNoTextField.placeholder = "9876543210"
        phoneNoTextField.applyAppThemeStyle()
        
        otpTextField.label.text = "Enter OTP here"
        otpTextField.placeholder = "X X X X X X"
        otpTextField.applyAppThemeStyle()
        
        configurePolicyTextView()
        
        otpResendButton.isEnabled = false
        timerSeconds = LimitCount.maxOTPResendSeconds
        otpResendTimeLabel.text = "(\(Date.intToMinSec(timerSeconds)))"
    }
    
    private func updateScreenUI() {
        policyStackView.isHidden = viewModel.isOTPSent
        phoneNoTextField.isUserInteractionEnabled = !viewModel.isOTPSent
        submitButton.setTitle(viewModel.isOTPSent ? "VERIFY" : "GET OTP", for: .normal)
        otpStackView.isHidden = !viewModel.isOTPSent
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
    
    private func initializeViewModel() {
        viewModel.reloadScreenUIClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.updateScreenUI()
                self?.startOTPTimer()
            }
        }
    }
    
    private func verifyOTP() {
        viewModel.verifyOTP { [weak self] isSuccess in
            DispatchQueue.main.async {
                self?.otpTextField.text = ""
                guard isSuccess else {
                    return
                }
                self?.invalidateOTPTimer()
            }
        }
    }
}


//MARK: Send OTP Functionality
extension LoginWithOTPViewController {
    
    private func invalidateOTPTimer() {
        timerSeconds = LimitCount.maxOTPResendSeconds
        otpResendTimeLabel.text = "(\(Date.intToMinSec(timerSeconds)))"
        timer?.invalidate()
        timer = nil
    }
    
    private func startOTPTimer() {
        invalidateOTPTimer()
        otpResendButton.isEnabled = false
        otpResendButton.setTitleColor(UIColor.appFireRed.withAlphaComponent(0.5), for: .normal)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.timerSeconds -= 1
            self.otpResendTimeLabel.text = "(\(Date.intToMinSec(timerSeconds)))"
            if !(self.timerSeconds > 0) {
                self.invalidateOTPTimer()
                self.otpResendButton.isEnabled = true
                self.otpResendButton.setTitleColor(UIColor.appFireRed, for: .normal)
            }
        }
    }
}


//MARK: - UITextViewDelegate
extension LoginWithOTPViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        UIApplication.shared.open(URL)
        // Prevent default behavior
        return false
    }
}


//MARK: - UITextFieldDelegate
extension LoginWithOTPViewController: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        setViewModelData(textField, textField.text)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty, let text = textField.text as? NSString else {
            return true
        }
        let finalText = text.replacingCharacters(in: range, with: string)
        var maxDigitCount = (textField == otpTextField) ? LimitCount.otpDigitsCount : LimitCount.phoneNoDigitsCount
        
        if (Double(finalText) == nil) || (finalText.count > maxDigitCount) {
            return false
        }
        setViewModelData(textField, finalText)
        return true
    }
    
    private func setViewModelData(_ textField: UITextField, _ text: String?) {
        switch textField {
        case phoneNoTextField:
            viewModel.phoneNumber = text ?? textField.text
            break
        case otpTextField:
            viewModel.otpCode = text ?? textField.text
            break
        default:
            break
        }
    }
}
