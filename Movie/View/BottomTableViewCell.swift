//
//  BottomTableViewCell.swift
//  Movie
//
//  Created by hafied Khalifatul ash.shiddiqi on 19/11/21.
//

import UIKit

class BottomTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var imageDown: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageDown.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
