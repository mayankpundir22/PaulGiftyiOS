//
//  MenuTableViewCell.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 16/03/24.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel.font = UIFont.gilroy(style: .bold, size: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
