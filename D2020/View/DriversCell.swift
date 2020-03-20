//
//  DriversCell.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos

class DriversCell: UITableViewCell {

    @IBOutlet weak var driverImage: RoundedImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverRateView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func callBtn(_ sender: Any) {
        
        
    }
    
    @IBAction func chatBtn(_ sender: Any) {
        
        
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        
        
    }
    
    
    

}
