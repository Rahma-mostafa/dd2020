//
//  countryViewController.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class countryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var countyTableView: UITableView!
    @IBOutlet weak var languageButtton1: RoundedButton!
    
    @IBOutlet weak var languageButtton2: RoundedButton!
    
    
    var country:[Country] = [Country(backgroundImage: .opaqueSeparator, image: "2000px-Flag_of_Egypt.svg", name: "مصر"),
                             Country(backgroundImage: .white, image: "4641082361_37d32d0bb3_z", name: "السعودية"),
                             Country(backgroundImage: .opaqueSeparator, image: "280px-Flag_of_Algeria.svg", name: "الجزائر "),
                             Country(backgroundImage:.white, image: "280px-Flag_of_Libya.svg", name:"ليبيا")]
    
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countyTableView.dataSource = self
        countyTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = countyTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell {
            cell.backgroundImageView.backgroundColor =  country[indexPath.item].backgroundImage
            cell.countryImageView.image = UIImage(named: country[indexPath.item].image!)
            cell.counrtyNameLabel.text = country[indexPath.item].name
        
        if indexPath.row % 2 == 0 {
                   cell.backgroundImageView.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
                   }
                   cell.button.tag = indexPath.row
                   cell.BackgroundImageColor = { [unowned self] in
                       cell.backgroundImageView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
                       }

                   return cell
               }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                   return 60
               }
    
    @IBAction func onLanguageButtonTapped(_ sender: Any) {
        languageButtton1.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)

    }
    
    @IBAction func onLanguageButtonTapped2(_ sender: Any) {
        languageButtton2.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
    }
    
    
    
    
    
    
    

}
