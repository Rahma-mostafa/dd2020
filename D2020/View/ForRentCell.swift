//
//  ForRentCell.swift
//  D2020
//
//  Created by Macbook on 3/1/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class ForRentCell: UICollectionViewCell {
    
    @IBOutlet weak var rentRoundedView: UIView!
    @IBOutlet weak var forRentImage: UIImageView!
    
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var forRentLbl: UILabel!
    
    @IBOutlet weak var forRentDesc: UILabel!
    
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
           coloredView.layer.cornerRadius = 15
           forRentImage.layer.cornerRadius = 15
           rentRoundedView.layer.cornerRadius = 15
           // Initialization code
       }
    
    
}
