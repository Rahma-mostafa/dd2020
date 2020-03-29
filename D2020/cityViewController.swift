//
//  cityViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class cityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var cityTableView: UITableView!
    var cityarr:[city] = [city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##"),city(name: "## حدد المدينة ##")]
    
    var shouldHideTable : ((String)->())!
    var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
    

    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return City2.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  cityTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? cityTableViewCell{
            cell.cityLabel.text = cityarr[indexPath.item].name
            cell.closeButton.tag = indexPath.row
            cell.onCloseButtonTapped = { [unowned self] in
                self.hideCityTable(rowIndex: indexPath.row)
                 cell.closeButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
            }
            if indexPath.row % 2 == 0 {
                               cell.closeButton.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
                           }
            return cell
        }
       
            
        return UITableViewCell()
    }
    func hideCityTable(rowIndex: Int){
        shouldHideTable(self.cityarr[rowIndex].name)
    }

}
