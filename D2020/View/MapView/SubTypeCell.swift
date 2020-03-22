//
//  subTypeCell.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SubTypeCell: UICollectionViewCell {
    
    @IBOutlet weak var subTypeImage: UIImageView!
    @IBOutlet weak var subTypeLbl: UILabel!
    @IBOutlet weak var fixedLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
                        
        let normalView = UIView(frame: bounds)
        normalView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        normalView.layer.cornerRadius = 5
        normalView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        normalView.layer.borderWidth = 0.2
        self.backgroundView = normalView

        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = #colorLiteral(red: 1, green: 0.340308845, blue: 0.3424271345, alpha: 1)
        selectedView.layer.cornerRadius = 5
        selectedView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        selectedView.layer.borderWidth = 0.2
        self.selectedBackgroundView = selectedView
        
    }
    
    
    func configureCell() {
        self.subTypeLbl.text = "مطاعم"
        self.subTypeImage.image = #imageLiteral(resourceName: "food")
    }
    
}
