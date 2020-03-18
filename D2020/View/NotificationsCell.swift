//
//  NotificationsCell.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell {
    
    
    @IBOutlet weak var notificationsImg: RoundedImageView!
    
    @IBOutlet weak var notificationsTitle: UILabel!
    @IBOutlet weak var notificationsDetails: UILabel!
    @IBOutlet weak var notificationsDate: UILabel!
    @IBOutlet weak var circledView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circledView.layer.cornerRadius = 30

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        circledView.layer.cornerRadius = 30
//
    }

}
