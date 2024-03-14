//
//  MapExistingCardViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 14/03/24.
//

import UIKit
import MaterialComponents

class MapExistingCardViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenDescLabel: UILabel!
    
    @IBOutlet weak var cardHolderNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var cardNumberTextField: MDCOutlinedTextField!
    @IBOutlet weak var cardKitNumberTextField: MDCOutlinedTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private lazy var viewModel: MapExistingCardViewModel = {
        let vwModel = MapExistingCardViewModel()
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
        viewModel.startMappingCardWithPhoneNumber()
    }
    
    
    private func setupLayout() {
        if let bgColor = view.backgroundColor {
            mainView.backgroundColor = bgColor
        }
        cardHolderNameTextField.delegate = self
        cardNumberTextField.delegate = self
        cardKitNumberTextField.delegate = self
        
        screenTitleLabel.font = UIFont.gilroy(style: .semibold, size: 16)
        screenDescLabel.font = UIFont.gilroy(style: .regular, size: 12)
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        submitButton.titleLabel?.font = UIFont.gilroy(style: .bold, size: 12)

        cardHolderNameTextField.label.text = "Card Holder Full Name"
        cardHolderNameTextField.placeholder = "Full Name"
        cardHolderNameTextField.applyAppThemeStyle()
        
        cardNumberTextField.label.text = "Enter Card No. (last \(LimitCount.maxCardDigitsAllowed) digits)"
        cardNumberTextField.placeholder = "XXXX"
        cardNumberTextField.applyAppThemeStyle()
        
        cardKitNumberTextField.label.text = "Enter Kit No. (\(LimitCount.cardKitNoDigitsCount) digits number)"
        cardKitNumberTextField.placeholder = "XXXXXXXXXX"
        cardKitNumberTextField.applyAppThemeStyle()
    }
    
    private func initializeViewModel() {
        viewModel.reloadScreenUIClosure = { [weak self] in
            DispatchQueue.main.async {
                //Code Here
            }
        }
    }
}


//MARK: - UITextFieldDelegate
extension MapExistingCardViewController: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        setViewModelData(textField, textField.text)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty, let text = textField.text as? NSString else {
            return true
        }
        let finalText = text.replacingCharacters(in: range, with: string)
        guard textField != cardHolderNameTextField else {
            setViewModelData(textField, finalText)
            return true
        }
        var maxDigitCount = (textField == cardKitNumberTextField) ? LimitCount.cardKitNoDigitsCount : LimitCount.maxCardDigitsAllowed
        if (Double(finalText) == nil) || (finalText.count > maxDigitCount) {
            return false
        }
        setViewModelData(textField, finalText)
        return true
    }
    
    private func setViewModelData(_ textField: UITextField, _ text: String?) {
        switch textField {
        case cardHolderNameTextField:
            viewModel.cardHolderName = text ?? textField.text
            break
        case cardNumberTextField:
            viewModel.cardNumber = text ?? textField.text
            break
        case cardKitNumberTextField:
            viewModel.cardKitNumber = text ?? textField.text
            break
        default:
            break
        }
    }
}
