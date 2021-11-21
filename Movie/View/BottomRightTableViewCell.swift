//
//  BottomRightTableViewCell.swift
//  Movie
//
//  Created by hafied Khalifatul ash.shiddiqi on 20/11/21.
//

import UIKit

class BottomRightTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRight: UILabel!
    @IBOutlet weak var imageRight: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRight.layer.cornerRadius = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
