//
//  OTPStackView.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 15/03/24.
//

import UIKit

protocol OTPStackViewDelegate: AnyObject {
    //always triggers when the OTP fields is valid
    func onOTPFieldCompleted(_ otpStackView: OTPStackView, otp: String)
}


class OTPStackView: UIStackView {
    
    var numberOfFields: Int = 6
    private var isSecureField: Bool = false
    private var textFieldsCollection: [OTPTextField] = []
    private var previousOTP: String = ""
    private let textFieldsSpacing: CGFloat = 8
    //Delegate Reference
    weak var delegate: OTPStackViewDelegate?
    //Realted Colors
    let inactiveFieldBorderColor = UIColor.appSilverGray
    let activeFieldBorderColor = UIColor.black
    let textForegroundColor = UIColor.appRoyalBlue
    let textBackgroundColor = UIColor.clear
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        //setupViewUI()
    }
    
    init(numberOfFields: Int, setInView: UIView?, isSecure: Bool = false) {
        self.isSecureField = isSecure
        self.numberOfFields = numberOfFields
        super.init(frame: setInView?.frame ?? .zero)
        setupViewUI(setInView: setInView)
    }
    
    //Customize OTPStackView according to user settings
    private final func setupViewUI(setInView: UIView? = nil) {
        self.alignment = .leading
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.distribution = .fillEqually
        self.contentMode = .center
        self.spacing = textFieldsSpacing
        //Setup OTP View Inside the SuperView
        guard let superView = setInView else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        //Add constraints to position the OTPStackView within SuperView
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.trailingAnchor.constraint(lessThanOrEqualTo: superView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
        ])
        addOTPFields()
    }
    
    //Adding each OTPTextField to OTPStackView
    private final func addOTPFields() {
        for index in 0..<numberOfFields {
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    //Customize OTPTextField according to user settings
    private final func setupTextField(_ textField: OTPTextField) {
        textField.delegate = self
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont.gilroy(style: .medium, size: 18)
        textField.textColor = textForegroundColor
        textField.backgroundColor = textBackgroundColor
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
        textField.keyboardType = .numberPad
        textField.textContentType = .oneTimeCode
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .yes
        textField.smartDashesType = .no
        textField.smartInsertDeleteType = .yes
        textField.smartQuotesType = .yes
        textField.spellCheckingType = .no
        self.addArrangedSubview(textField)
        //Add constraints related to OTPTextField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: self.frame.height).isActive = true
    }
    
    //Setup OTPTextFields Color
    private final func updateTextFieldsColor(_ currentTextField: UITextField) {
        for textField in textFieldsCollection {
            textField.layer.borderColor = inactiveFieldBorderColor.cgColor
            if currentTextField == textField {
                textField.layer.borderColor = activeFieldBorderColor.cgColor
            }
        }
    }
    
    private final func secureCurrentTextField(_ textField: UITextField) {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            textField.isSecureTextEntry = true
            timer.invalidate()
        }
    }
    
    //Checks if all the OTPTextFields are filled
    private final func checkForOTPValidity() {
        var validOTP = ""
        for textField in textFieldsCollection {
            guard let text = textField.text?.trimmed, text.count == 1, text.isNumeric else {
                return
            }
            validOTP += text
        }
        guard previousOTP != validOTP else {
            return
        }
        previousOTP = validOTP
        delegate?.onOTPFieldCompleted(self, otp: validOTP)
    }
    
    //Autofill OTPTextFields starting from first
    private final func autoFillTextField(with string: String) {
        var remainingStrStack = string.reversed().compactMap{ String($0) }
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        checkForOTPValidity()
    }
    
    //Gives the OTP text
    final func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection {
            OTP += textField.text?.trimmed ?? ""
        }
        return OTP
    }
    
    //Empty all OTPTextFields
    final func emptyOTPTextFields() {
        for textField in textFieldsCollection {
            textField.text = ""
        }
    }
}


//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateTextFieldsColor(textField)
        textField.isSecureTextEntry = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForOTPValidity()
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
        if isSecureField {
            secureCurrentTextField(textField)
        }
    }
    
    //switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0 && string == "") {
                return false
            } else if (range.length == 0) {
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
}

