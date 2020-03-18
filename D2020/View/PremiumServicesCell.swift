//
//  PremiumServicesCell.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PremiumServicesCell: UICollectionViewCell {
    @IBOutlet weak var circledImage: UIImageView!
    
    @IBOutlet weak var circledView: UIView!
    
override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    circledView.layer.cornerRadius = 30

}
}
