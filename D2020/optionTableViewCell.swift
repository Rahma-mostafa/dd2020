//
//  optionTableViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class optionTableViewCell: UITableViewCell {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var optionLabel: UILabel!

    var onCloseButtonTapped: (()->())!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onCloseButtonClick(_ sender: Any) {
        onCloseButtonTapped()
    }
}
