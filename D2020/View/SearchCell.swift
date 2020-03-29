//
//  DriversCell.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var searchLbl: UILabel!

    func setup() {
        guard let model = model as? String else { return }
        searchLbl.text = model
    }
}

