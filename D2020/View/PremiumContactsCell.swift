//
//  PremiumContactsCell.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PremiumContactsCell: UITableViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var coloredView: RoundedShadowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
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
