//
//  changeCityTableViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class changeCityTableViewCell: UITableViewCell {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var cityLabel: UILabel!
    var onCloseButtonTapped: (()->())!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     closeButton.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onCloseButtonTapped(_ sender: Any) {
        onCloseButtonTapped()

    }
    
}
