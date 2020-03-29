//
//  productsCollectionViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos
class StoreCommentCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var commentTxf: UITextField!

    func setup() {
        guard let model = model as? StoreDetail.Comment else { return }
        userImage.setImage(url: model.image)
        username.text = model.name
        rate.rating = Double(model.rate ?? "0") ?? 0
        commentTxf.text = model.comment
    }
}
