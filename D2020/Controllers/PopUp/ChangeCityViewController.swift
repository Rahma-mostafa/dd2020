//
//  changeCityViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire


class ChangeCityViewController: BaseController {
   
    
    @IBOutlet weak var cityTableView: UITableView!
     var shouldHideTable : ((String, Int)->())!
     var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var cityArray:[City.Datum] = []
    var Country:Int? = CountryViewController.deviceCountry?.id ?? 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCity()
    }
    
    @IBAction func onDismissButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setup() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }
    
    func fetchCity() {
             startLoading()
        let method = api(.SubCountry , [Country ?? 0])
               ApiManager.instance.headers["Country_id"] = "\( Country ?? 0)"
               ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
                 self?.stopLoading()
                 let data = try? JSONDecoder().decode(City.self, from: response ?? Data())
                     self?.cityArray.append(contentsOf: data?.data ?? [])
                     self?.cityTableView.reloadData()
                 
             }
     }
    func hideCityTable(rowIndex: Int){
        shouldHideTable(self.cityArray[rowIndex].name ?? "" , self.cityArray[rowIndex].id ?? 0 )
           self.dismiss(animated: true)
    }
}
    extension ChangeCityViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return cityArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if let cell =  cityTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? ChangeCityTableViewCell{
               cell.cityLabel.text = cityArray[indexPath.item].name
               cell.closeButton.tag = indexPath.row
               cell.onCloseButtonTapped = { [unowned self] in
                    self.hideCityTable(rowIndex: indexPath.row)
                    //cell.closeButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
               }
               if indexPath.row % 2 == 0 {
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
                }
               return cell
           }
        return UITableViewCell()
        }
   
     }
