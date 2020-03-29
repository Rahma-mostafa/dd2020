//
//  productsCollectionViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class productsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: RoundedImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
}
