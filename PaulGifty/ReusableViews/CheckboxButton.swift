//
//  CheckboxButton.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit


protocol CheckboxButtonDelegate: AnyObject {
    func didChangeCheckboxValue(checkbox: CheckboxButton, isChecked: Bool)
}

class CheckboxButton: UIButton {
    
    weak var delegate: CheckboxButtonDelegate?
    
    var borderColor: UIColor = UIColor.appRoyalBlue {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupCheckbox()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCheckbox()
    }
    
    private func setupCheckbox() {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        updateImage()
    }
    
    private func updateImage() {
        if isChecked {
            let checkmarkImage = UIImage(systemName: "checkmark")?.withTintColor(borderColor, renderingMode: .alwaysTemplate)
            setImage(checkmarkImage, for: .normal)
        } else {
            setImage(nil, for: .normal)
        }
    }
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
        delegate?.didChangeCheckboxValue(checkbox: self, isChecked: isChecked)
    }
}
