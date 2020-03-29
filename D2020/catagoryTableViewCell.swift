//
//  catagoryTableViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/11/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class catagoryTableViewCell: UITableViewCell {

    @IBOutlet weak var catagoryImageView: UIImageView!
    @IBOutlet weak var catagoryName: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var onCloseButtonTapped: (()->())!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        closeButton.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onCloseButtonTapped(_ sender: Any) {
        onCloseButtonTapped()
    }
    
    
}
