//
//  ForRentAdsCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/27/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos

class ForRentAdsCell: UITableViewCell {
    
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var didSelectedImg: UIImageView!
    @IBOutlet weak var didSelectedTitle: UILabel!
    @IBOutlet weak var didSelectedKm: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var premiumImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RoundedView.layer.shadowColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 0.16)
        RoundedView.layer.shadowOpacity = 0.4
        RoundedView.layer.shadowOffset = CGSize.zero
        RoundedView.layer.shadowRadius = 3
        starView.settings.updateOnTouch = false
        starView.settings.starSize = 13
        starView.settings.filledImage = UIImage(named: "greenStar")
        starView.settings.emptyImage = UIImage(named: "emtyStar")
        premiumImageView.layer.cornerRadius = 8
        
        
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
