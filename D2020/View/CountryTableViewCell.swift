//
//  CountryTableViewCell.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: RoundedImageView!
    @IBOutlet weak var counrtyNameLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var BackgroundImageColor: (()->())!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    override var frame: CGRect {
//               get {
//                   return super.frame
//               }
//               set (newFrame) {
//                   var frame =  newFrame
//                   frame.origin.y += 4
//                   frame.size.height -= 2 * 4
//                   super.frame = frame
//
    
    
    
//}
    
    @IBAction func onButtonTapped(_ sender: Any) {
        
        BackgroundImageColor()

    }
    
    
    
    
    
    
        
    }


