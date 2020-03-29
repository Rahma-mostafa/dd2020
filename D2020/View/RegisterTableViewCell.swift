//
//  RegisterTableViewCell.swift
//  D2020
//
//  Created by Macbook on 3/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    @IBOutlet weak var imgRegister: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleRegister: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
