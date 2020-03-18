//
//  PremiumSelectingCell.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PremiumSelectingCell: UITableViewCell {
    
    @IBOutlet weak var premiumImage: RoundedImageView!
    
    @IBOutlet weak var premiumTitleImage: UILabel!
    
    @IBOutlet weak var premiumKm: UILabel!
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
