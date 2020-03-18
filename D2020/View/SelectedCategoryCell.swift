//
//  SelectedCategoryCell.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SelectedCategoryCell: UITableViewCell {

    @IBOutlet weak var didSelectedImg: UIImageView!
    
    @IBOutlet weak var didSelectedTitle: UILabel!
    
    @IBOutlet weak var didSelectedKm: UILabel!
    
    
    @IBOutlet var didSelectedStarBtn: [UIButton]!
    
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
    
    
    @IBAction func didSelectTag(_ sender: Any) {
    }
    
    @IBAction func didSelectedStarBtnPressed(_ sender: Any) {
        
        print("Rated \((sender as AnyObject).tag)stars.")
            
            for button in didSelectedStarBtn{
                if button.tag <= (sender as AnyObject).tag {
                   //selected
                    button.setBackgroundImage(UIImage.init(named: "star (3)"), for: .normal)
                }else{
                    //not selected
                     button.setBackgroundImage(UIImage.init(named: "star (notSelected)"), for: .normal)
                    
                }
            }
        
        
        
    }
    
}
