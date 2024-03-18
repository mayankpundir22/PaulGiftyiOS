//
//  HomeViewController.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 16/03/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    
    //Right Side Views
    @IBOutlet weak var cardsTableTitleLabel: UILabel!
    @IBOutlet weak var cardsTable: UITableView!
    
    private let totalCards: Int = 5
    private var selectedCardIndexPath: IndexPath?
    
    private lazy var viewModel: HomeViewModel = {
        let vwModel = HomeViewModel()
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
    }
    
    
    private func setupLayout() {
        welcomeLabel.font = UIFont.gilroy(style: .regular, size: 16)
        userNameLabel.font = UIFont.gilroy(style: .semibold, size: 23)
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
        
        
        //Right Side Views
        cardsTable.delegate = self
        cardsTable.dataSource = self
        //cardsTable.rowHeight = tableCellHeight + tableCellsGap
        cardsTable.showsVerticalScrollIndicator = false
        cardsTable.showsHorizontalScrollIndicator = false
        cardsTable?.register(UINib(nibName: CardPickerTableViewCell.className, bundle: Bundle.main), forCellReuseIdentifier: CardPickerTableViewCell.className)
    }
    
    private func initializeViewModel() {
        viewModel.reloadScreenUIClosure = { [weak self] in
            DispatchQueue.main.async {
                // Code Here
            }
        }
    }
}


//MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCards
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardPickerTableViewCell.className, for: indexPath) as? CardPickerTableViewCell else {
            return UITableViewCell()
        }
        cell.setupUI(
            title: "2548", 
            isSelectedCard: selectedCardIndexPath == indexPath,
            isLastCell: indexPath.row == (totalCards - 1)
        )
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // The selected cell is tapped again, deselect it
        if let selectedIndexPath = tableView.indexPathForSelectedRow, selectedIndexPath == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard indexPath.row < (totalCards - 1) else {
            return
        }
        selectedCardIndexPath = indexPath
        cardsTable.reloadData()
    }
}
