//
//  CodeCell.swift
//  D2020
//
//  Created by Macbook on 3/27/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class CodeCell: UITableViewCell {

    @IBOutlet weak var imgCode: UIImageView!
    @IBOutlet weak var codeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
