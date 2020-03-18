//
//  catagoryTableViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/11/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class catagoryTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var catagoryTableView: UITableView!
    var catagory:[Products] = [Products(image: "food", name: "مطعم", price: "40 جنيه"),Products(image: "89e383d6895717eb3d5e76fb6f9835f5", name: "مطعم", price: "40 جنيه"),Products(image: "89e383d6895717eb3d5e76fb6f9835f5", name: "مطعم", price: "40 جنيه"),Products(image: "89e383d6895717eb3d5e76fb6f9835f5", name: "مطعم", price: "40 جنيه"),Products(image: "89e383d6895717eb3d5e76fb6f9835f5", name: "مطعم", price: "40 جنيه"),Products(image: "89e383d6895717eb3d5e76fb6f9835f5", name: "مطعم", price: "40 جنيه")]
     var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var shouldHideTable : ((String)->())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catagoryTableView.delegate = self
        catagoryTableView.dataSource = self
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = catagoryTableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath) as? catagoryTableViewCell {
            cell.catagoryImageView.image = UIImage(named:catagory[indexPath.row].image )
            cell.catagoryName.text = catagory[indexPath.item].name
            cell.closeButton.tag = indexPath.row
            cell.onCloseButtonTapped = { [unowned self] in
                self.hideTable(rowIndex: indexPath.row)
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
            }
               if indexPath.row % 2 == 0 {
                   cell.closeButton.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
               }
            return cell
        }
        return UITableViewCell()
    }
    
    func hideTable(rowIndex: Int){
        shouldHideTable(self.catagory[rowIndex].name)
    }
    
}
