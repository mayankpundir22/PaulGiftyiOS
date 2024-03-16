//
//  MenuViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 16/03/24.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var supportButton: UIButton!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneNoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var userName: String?
    var userPhoneNo: String?
    private let tableCellsGap: CGFloat = 16
    private let tableCellHeight: CGFloat = 49
    private let menuOptions: [MenuOption] = [.transactions, .termsAndConditions, .privacyPolicy, .grievancePolicy]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDummyData()
        setupLayout()
        updateScreenUI()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
    }
    
    @IBAction func supportButtonPressed(_ sender: Any) {
        UIAlertController.showAlert(self, 
            title: Strings.paulGifty,
            message: AlertMessage.CALL_TO_CUSTOMER_CARE,
            actions: .Call, .Cancel) { [weak self] action in
                guard action == .Call else {
                    return
                }
                self?.callToSupportTeam()
            }
    }
    
    
    private func setupLayout() {
        supportButton.layer.cornerRadius = supportButton.frame.height / 2
        supportButton.titleLabel?.font = UIFont.gilroy(style: .bold, size: 12)
        
        menuLabel.font = UIFont.gilroy(style: .regular, size: 16)
        userNameLabel.font = UIFont.gilroy(style: .semibold, size: 23)
        userPhoneNoLabel.font = UIFont.gilroy(style: .regular, size: 16)
        
        //Setup for TableView - tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = tableCellHeight + tableCellsGap
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView?.register(UINib(nibName: MenuTableViewCell.className, bundle: Bundle.main), forCellReuseIdentifier: MenuTableViewCell.className)
    }
    
    private func updateScreenUI() {
        userNameLabel.text = userName
        userPhoneNoLabel.text = userPhoneNo
        tableView.reloadData()
    }
    
    private func clickedOnMenuOption(_ menuOption: MenuOption) {
        switch menuOption {
        case .notifications:
            break
        case .transactions:
            break
        case .frequentlyAskedQuestions:
            break
        case .termsAndConditions:
            Utility.openExternalLink(AppSupport.termsAndConditionsURL)
            break
        case .privacyPolicy:
            Utility.openExternalLink(AppSupport.privacyPolicyURL)
            break
        case .grievancePolicy:
            Utility.openExternalLink(AppSupport.grievancePolicyURL)
            break
        }
    }
    
    private func callToSupportTeam() {
        Utility.openExternalLink("tel://\(AppSupport.phoneNumber)") { [weak self] isSuccess in
            if !isSuccess {
                UIAlertController.showAlert(self, title: "", message: AlertMessage.DEVICE_NOT_SUPPORT_CALL)
            }
        }
    }
}


//MARK: - UITableViewDataSource & UITableViewDelegate
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.className, for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        let option = menuOptions[indexPath.row]
        cell.titleLabel.text = option.title
        cell.iconImageView.image = UIImage(named: option.icon)
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // The selected cell is tapped again, deselect it
        if let selectedIndexPath = tableView.indexPathForSelectedRow, selectedIndexPath == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        clickedOnMenuOption(menuOptions[indexPath.row])
    }
}


//MARK: Testing Purpose - TODO - Remove before production ----
extension MenuViewController {
    
    private func setDummyData() {
        userName = "Mayank Thakur"
        userPhoneNo = "+91 9876543210"
    }
}
