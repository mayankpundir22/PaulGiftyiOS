//
//  CardPickerTableViewCell.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 16/03/24.
//

import UIKit

class CardPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var isSelectedCard: Bool = false
    var isLastCell: Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        arrowView.roundCorners([.topRight, .bottomRight], radius: arrowView.frame.width / 2)
        buttonView.roundCorners([.allCorners], radius: buttonView.frame.height / 2)
        iconImageView.roundCorners([.allCorners], radius: iconImageView.frame.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setupUI(title: String?, isSelectedCard: Bool, isLastCell: Bool) {
        arrowView.isHidden = !isSelectedCard
        button.isHidden = !isLastCell
        iconImageView.isHidden = isLastCell
        if isLastCell {
            titleLabel.text = "Add a card"
            buttonView.backgroundColor = UIColor.appGoldenrodBrown
            return
        }
        titleLabel.text = title
        buttonView.backgroundColor = isSelectedCard ? .white : .appGoldenrodBrown
        iconImageView.image = isSelectedCard ? UIImage(named: "gift-card-half-icon-blue") : UIImage(named: "gift-card-first-half-icon-blue")
    }
}
