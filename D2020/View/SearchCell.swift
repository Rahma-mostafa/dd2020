//
//  DriversCell.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

protocol SearchCellDelegate: class {
    func didRemoveHistory(path: Int)
}
class SearchCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var searchLbl: UILabel!

    weak var delegate: SearchCellDelegate?
    func setup() {
        guard let model = model as? String else { return }
        searchLbl.text = model
        deleteBtn.UIViewAction { [weak self] in
            self?.delegate?.didRemoveHistory(path: self?.indexPath() ?? 0)
        }
    }
}

