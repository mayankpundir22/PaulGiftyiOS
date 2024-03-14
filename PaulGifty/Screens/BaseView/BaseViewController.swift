//
//  BaseViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit
import Toast_Swift

class BaseViewController: UIViewController {
    
    var baseVwModel: BaseViewModel? {
        didSet {
            initializeViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showToast(_ textMessage: String) {
        view.makeToast(textMessage)
    }
    
    func showLoadingIndicator() {
        if let loadingVC = Storyboard.Other.instantiateVC(type: LoadingViewController.self) {
            loadingVC.modalPresentationStyle = .fullScreen
            present(loadingVC, animated: false)
        }
    }
    
    func hideLoadingIndicator() {
        if let vc = UIApplication.topViewController() as? LoadingViewController {
            vc.dismiss(animated: false)
        }
    }
    
    private func initializeViewModel() {
        baseVwModel?.showValidationErrorClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.baseVwModel?.validationErrorMessage {
                    self?.view.makeToast(message)
                }
            }
        }
        
        baseVwModel?.showAlertClosure = { [weak self] (_ isError:Bool) in
            DispatchQueue.main.async {
                if let message = self?.baseVwModel?.errorMessage {
                    UIAlertController.showAlert(self, title: "", message: message)
                }
            }
        }
        
        baseVwModel?.updateLoadingStatus = { [weak self] (_ isShow: Bool) in
            DispatchQueue.main.async {
                if isShow {
                    self?.showLoadingIndicator()
                } else {
                    self?.hideLoadingIndicator()
                }
            }
        }
    }
}
