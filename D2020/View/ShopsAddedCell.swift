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
    
    var style: Style = .orange
    
    var setStyle: Style {
        get {
            return style
        } set {
            style = newValue
            switch newValue {
            case .orange:
                shopsTag.backgroundColor = .orangeFade
                shopsTag.setTitleColor(.appOrange, for: .normal)
                ratingView.settings.filledImage = UIImage(named: "star (3)")
                imageIcon.image = UIImage(named: "grediantBackground")
                addNewShopLbl.text = "add.new.store.lan".localized
            case .green:
                shopsTag.backgroundColor = .appGreen
                shopsTag.setTitleColor(.white, for: .normal)
                ratingView.settings.filledImage = UIImage(named: "star (4)")
                imageIcon.image = UIImage(named: "greenGradLarge")
                addNewShopLbl.text = "add.new.ads.lan".localized
            case .red:
                shopsTag.backgroundColor = .appRed
                shopsTag.setTitleColor(.white, for: .normal)
                ratingView.settings.filledImage = UIImage(named: "star (5)")
                imageIcon.image = UIImage(named: "redGradLarge")
                addNewShopLbl.text = "add.new.product.lan".localized
            }
        }
        
    }
  
    func setupDefault() {
        if premImage != nil {
            premImage.isHidden = true
        }
        shopsTitleAdd.isHidden = true
        shopsTag.isHidden = true
        trash.isHidden = true
        ratingView.isHidden = true
        addNewShopLbl.isHidden = false
        plusBtn.isHidden = false
        
    }
    func setup() {
        guard let model = model as? MyStores.Datum else { return }
        addNewShopLbl.isHidden = true
        plusBtn.isHidden = true
        imageIcon.setImage(url: model.image)
        shopsTitleAdd.text = model.name
        ratingView.rating = Double(model.rate ?? 0)
        if style == .orange {
            shopsTag.setTitle(model.catName, for: .normal)
        } else {
            shopsTag.setTitle("\(model.price ?? 0)", for: .normal)
        }
        if premImage != nil {
            if model.type == 1 {
                premImage.isHidden = false
            } else {
                premImage.isHidden = true
            }
        }
        
    }
    
}

