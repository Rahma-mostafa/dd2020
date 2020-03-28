//
//  SelectedCategoryCell.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos

class SelectedCategoryCell: UITableViewCell {

    @IBOutlet weak var didSelectedImg: UIImageView!
    
    @IBOutlet weak var didSelectedTitle: UILabel!
    
    @IBOutlet weak var didSelectedKm: UILabel!
    
    @IBOutlet weak var starView: CosmosView!
    

    @IBOutlet weak var saveButton: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        starView.settings.updateOnTouch = false
        starView.settings.starSize = 13
        starView.settings.filledImage = UIImage(named: "star (3)")
        starView.settings.emptyImage = UIImage(named: "emtyStar")
        
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
    
    
    @IBAction func didSelectTag(_ sender: Any) {
    }
    

    
}
