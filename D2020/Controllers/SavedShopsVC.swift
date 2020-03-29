//
//  SavedShops.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//


struct SavedShops {
    var imageSave:String?
    var titleSave:String?
    var kmSave:String?
}




import UIKit

class SavedShopsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tb: UITableView!
     
    
    
    var shopsSaved : [SavedShops] = [SavedShops(imageSave: "cold brew", titleSave: "كافيه الغروب", kmSave: "12KM"),SavedShops(imageSave: "cold brew", titleSave: "كافيه الغروب", kmSave: "12KM"),SavedShops(imageSave: "cold brew", titleSave: "كافيه الغروب", kmSave: "12KM"),SavedShops(imageSave: "cold brew", titleSave: "كافيه الغروب", kmSave: "12KM"),SavedShops(imageSave: "cold brew", titleSave: "كافيه الغروب", kmSave: "12KM"),SavedShops(imageSave: "cold brew", titleSave: "كافيه الغروب", kmSave: "12KM")]

    override func viewDidLoad() {
        super.viewDidLoad()

        tb.delegate = self
               tb.dataSource = self
        
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return shopsSaved.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.ShopsSaved , for: indexPath) as! ShopsSaved
            
            cell.savedImage.image = UIImage(named: shopsSaved[indexPath.row].imageSave!)
            
            cell.savedTitle.text = shopsSaved[indexPath.row].titleSave
            
            cell.Date.text = shopsSaved[indexPath.row].kmSave
            

            
            return cell
           }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        

    }
