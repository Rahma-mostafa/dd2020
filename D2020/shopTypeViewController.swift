//
//  shopTypeViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class shopTypeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var shopTypeTableView: UITableView!
    var catagory:[ShopType] = [ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),ShopType( name: "نوع"),                                  ]
         var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        var shouldHideTypeTable : ((String)->())!
        override func viewDidLoad() {
            super.viewDidLoad()
            shopTypeTableView.delegate = self
            shopTypeTableView.dataSource = self
            
            
        }
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return catagory.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = shopTypeTableView.dequeueReusableCell(withIdentifier: "shopTypeCell", for: indexPath) as? shopTypeTableViewCell {
                cell.shopTypeLabel.text = catagory[indexPath.item].name
                cell.closeButton.tag = indexPath.row
                cell.onCloseButtonTapped = { [unowned self] in
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
                self.hidetypeTable(rowIndex: indexPath.row)
                }
                if indexPath.row % 2 == 0 {
                    cell.closeButton.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
                }
                return cell
            }
            return UITableViewCell()
        }
        
        func hidetypeTable(rowIndex: Int){
            shouldHideTypeTable(self.catagory[rowIndex].name)
            
            
        }
        
    }
