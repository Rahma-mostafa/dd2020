//
//  ShopsAddedCell.swift
//  D2020
//
//  Created by Macbook on 3/5/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class ShopsAddedCell: UITableViewCell, CellProtocol {
    
    @IBOutlet weak var premImage: UIImageView!
    @IBOutlet weak var shopsTitleAdd: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var shopsTag: RoundedButton!
    @IBOutlet weak var trash: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var addNewShopLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupDefault() {
        premImage.isHidden = true
        shopsTitleAdd.isHidden = true
        shopsTag.isHidden = true
        trash.isHidden = true
        ratingView.isHidden = true
        addNewShopLbl.isHidden = false
        plusBtn.isHidden = false
        imageIcon.image = UIImage(named: "grediantBackground")
        addNewShopLbl.text = "add.new.store.lan".localized
    }
    func setup() {
        guard let model = model as? MyStores.Datum else { return }
        addNewShopLbl.isHidden = true
        plusBtn.isHidden = true
        imageIcon.setImage(url: model.image)
        shopsTitleAdd.text = model.name
        shopsTag.setTitle(model.catName, for: .normal)
        ratingView.rating = Double(model.rate ?? 0)
        if model.type == 1 {
            premImage.isHidden = false
        } else {
            premImage.isHidden = true
        }
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

