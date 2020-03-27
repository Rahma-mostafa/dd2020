//
//  changeCityViewController.swift
//  D2020
///Users/macbook/Downloads/ChangeCityViewController.swift
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire

//struct cities {
//    var name: String?
//}

class ChangeCountryViewController: BaseController {
   
    
    @IBOutlet weak var cityTableView: UITableView!
     var shouldHideTable : ((String)->())!
     var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var cityArray:[City] = []

//    var cityArray:[cities] = [cities(name: "cairo")]

//    var Country:Int? = 26
    
    var countries: [Country.CountryData] = []

    
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
//     func fetchCountries() {
//           startLoading()
//           //ApiManager.instance.paramaters[] =
//           ApiManager.instance.connection(.MainCountry, type: .get) { [weak self] (response) in
//               self?.stopLoading()
//               let data = try? JSONDecoder().decode(Country.self, from: response ?? Data())
//               if case data?.status = true {
//                   self?.countries.append(contentsOf: data?.data ?? [])
//                   self?.cityTableView.reloadData()
//               }
//           }
//    }
    
    
    
    func fetchCity() {
             startLoading()
        let method = api(.SubCountry, [String(CountryViewController.deviceCountry?.id ?? 0)])
//               ApiManager.instance.headers["Country_id"] = String(CountryViewController.deviceCountry?.id ?? 0)
               ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
                 self?.stopLoading()
                 let data = try? JSONDecoder().decode(CityModel.self, from: response ?? Data())
                self?.cityArray.append(contentsOf: data?.data ?? [])
                     self?.cityTableView.reloadData()

             }
     }
    func hideCityTable(rowIndex: Int){
        shouldHideTable(self.cityArray[rowIndex].name! )
           self.dismiss(animated: true)
    }
}



    extension ChangeCountryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return cityArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if let cell =  cityTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? changeCityTableViewCell{
               cell.cityLabel.text = cityArray[indexPath.item].name
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
   
     }
