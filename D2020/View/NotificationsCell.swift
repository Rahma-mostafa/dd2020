//
//  NotificationsCell.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell, CellProtocol {
    
    
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

    func setup() {
        guard let model = model as? NotificationModel.Datum else { return }
        notificationsImg.setImage(url: model.image)
        notificationsTitle.text = model.title
        notificationsDetails.text = model.content
        notificationsDate.text = model.date
    }

}
