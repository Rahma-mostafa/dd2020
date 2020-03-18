//
//  ShopsAddedCell.swift
//  D2020
//
//  Created by Macbook on 3/5/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class ShopsAddedCell: UITableViewCell {

    @IBOutlet weak var shopsTitleAdd: UILabel!
    @IBOutlet weak var ImageFrameColor: RoundedShadowView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var shopsTag: RoundedButton!
    @IBOutlet weak var trash: RoundedButton!
    //Outlets Add A Shop
    
    @IBOutlet weak var imageIconB: RoundedImageView!
    @IBOutlet weak var addAShop: UILabel!
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
