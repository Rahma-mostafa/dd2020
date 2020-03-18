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
    
    @IBOutlet var starBtn: [UIButton]!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedVew.layer.cornerRadius = 11
       
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func starPressed(_ sender: UIButton) {
        print("Rated \(sender.tag)stars.")
        
        for button in starBtn{
            if button.tag <= sender.tag {
               //selected
                button.setBackgroundImage(UIImage.init(named: "star (3)"), for: .normal)
            }else{
                //not selected
                 button.setBackgroundImage(UIImage.init(named: "star (notSelected)"), for: .normal)
                
            }
        }
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
