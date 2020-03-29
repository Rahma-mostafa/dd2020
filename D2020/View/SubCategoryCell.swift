//
//  SubCategoryCell.swift
//  D2020
//
//  Created by Macbook on 2/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {

    @IBOutlet weak var subCategoryImg: UIImageView!
    
    @IBOutlet weak var subCategoryTitle: UILabel!
    
    @IBOutlet weak var roundedView: RoundedShadowView!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 8
        subCategoryImg.layer.cornerRadius = 7
        
        
        
    }
//    
    override func layoutSubviews() {
               super.layoutSubviews()
               let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
               bounds = bounds.inset(by: padding)
        }

}
