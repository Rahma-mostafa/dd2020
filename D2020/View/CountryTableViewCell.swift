//
//  CountryTableViewCell.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var countryImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: RoundedImageView!
    @IBOutlet weak var counrtyNameLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var onClick: HandlerView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func setup() {
        guard let model = model as? Country.CountryData else { return }
        countryImageView.setImage(url: model.file)
        counrtyNameLabel.text = model.name
                      
                         
    }
    @IBAction func onButtonTapped(_ sender: Any) {
        onClick?()
        //BackgroundImageColor()

    }
    
    
    
    
    
    
        
    }


