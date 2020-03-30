//
//  AfterSelectingCell.swift
//  D2020
//
//  Created by Macbook on 2/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class AfterSelectingCell: UITableViewCell {
    
    

    @IBOutlet weak var premiumLogo: UIImageView!
    
    @IBOutlet weak var roundedVew: UIView!
    
    @IBOutlet weak var imageSelected: UIImageView!
    
   
    @IBOutlet weak var titleSelected: UILabel!
    
    @IBOutlet weak var kmSelected: UILabel!

    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tagButton: RoundedButton!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedVew.layer.cornerRadius = 11
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 4
            super.frame = frame
        }
    }
    
    
    
    

    
}
