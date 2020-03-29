//
//  AgentsCell.swift
//  D2020
//
//  Created by Macbook on 3/1/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class AgentsCell: UITableViewCell {
    @IBOutlet weak var imageAgent: UIImageView!
    @IBOutlet weak var agentLbl: UILabel!
    
    @IBOutlet weak var agentDesc: UILabel!
    @IBOutlet weak var bkImageAgent: RoundedImageView!
    
    @IBOutlet weak var bkImageB: RoundedImageView!
    @IBOutlet weak var imageAgentB: UIImageView!
    @IBOutlet weak var agentLblB: UILabel!
    
    @IBOutlet weak var agentDescB: UILabel!
    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var labelMenu: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
