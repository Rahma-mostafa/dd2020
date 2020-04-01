//
//  AdsPeriodCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/27/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class AdsPeriodCell: UICollectionViewCell {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    var onButtonTapped: (()->()) = {}

    
     override func awakeFromNib() {
        roundedView.layer.cornerRadius = 8
        whiteView.layer.cornerRadius = 8
        
    }
    
    @IBAction func onSelectButtonCilick(_ sender: Any) {
        onButtonTapped()
    }
    
}
