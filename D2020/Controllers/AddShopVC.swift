//
//  AddShopVC.swift
//  D2020
//
//  Created by Macbook on 3/5/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct AddShop {
    var imageFrame : String?
    var imageIconAdd:String?
    var shopLbl:String?
    var addShopLbl:String?
    var btnTaG:String?
    var trashIcon:String?
}

class AddShopVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    
    
    

    @IBOutlet weak var tableViewB: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    //Variables :TableView:-
    
    var shopAdded:[AddShop] = [AddShop(imageFrame: .none, imageIconAdd: "maksim-zhashkevych-qXfLGt9nh2Y-unsplash", shopLbl: "كافيه الغروب", addShopLbl: .none, btnTaG: "كافيه", trashIcon: "red_trash"),AddShop(imageFrame: .none, imageIconAdd: "Concrete PENTAHOUSE by Wamhouse Studio", shopLbl: "مطعم ابو بكر", addShopLbl: .none, btnTaG: "مطعم", trashIcon: "red_trash")]
    
    var addNewShop:[AddShop] = [AddShop(imageFrame: .none, imageIconAdd: "iconfinder_add_134224", shopLbl: .none, addShopLbl: "اضافة محل اخر", btnTaG: .none, trashIcon: .none)]
    
    var contentIndex : Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewB.delegate = self
        tableViewB.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    func customInit(contentIndex:Int,title:String) {

        self.contentIndex = contentIndex
        self.title = title

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
        return addNewShop.count
    }
        return shopAdded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView{
            
            
                   let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.ShopsAddedCell , for: indexPath) as! ShopsAddedCell
            cell.addAShop.text = addNewShop[indexPath.row].addShopLbl
            cell.imageIconB.image = UIImage(named: addNewShop[indexPath.row].imageIconAdd!)
        return cell
            
        }
        let cell2 = tableView.dequeueReusableCell(withIdentifier:Identifiers.ShopsAddedCell , for: indexPath) as! ShopsAddedCell
        
        cell2.imageIcon.image = UIImage(named:shopAdded[indexPath.row].imageIconAdd!)
        
        cell2.shopsTitleAdd.text = shopAdded[indexPath.row].shopLbl
        
//        cell.shopsTag.text = shopAdded[indexPath.row].btnTaG
        
//        cell.trash.im = UIImage(named: shopAdded[indexPath.row].trashIcon!)
         return cell2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //performSegue(withIdentifier: Segues.ToAddShopDetails, sender: self)

    }
}
