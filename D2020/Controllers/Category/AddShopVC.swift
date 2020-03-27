//
//  AddShopVC.swift
//  D2020
//
//  Created by Macbook on 3/5/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire

struct AddShop {
    var imageFrame : String?
    var imageIconAdd:String?
    var shopLbl:String?
    var addShopLbl:String?
    var btnTaG:String?
    var trashIcon:String?
}

class AddShopVC: BaseController  {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shopsLabel: UILabel!
    @IBOutlet weak var shopsAddedLabel: UILabel!
    @IBOutlet weak var tableViewB: UITableView!
    @IBOutlet weak var tableView: UITableView!
        //Variables :TableView:-
    
//    var shopAdded:[AddShop] = [AddShop(imageFrame: .none, imageIconAdd: "maksim-zhashkevych-qXfLGt9nh2Y-unsplash", shopLbl: "كافيه الغروب", addShopLbl: .none, btnTaG: "كافيه", trashIcon: "red_trash"),AddShop(imageFrame: .none, imageIconAdd: "Concrete PENTAHOUSE by Wamhouse Studio", shopLbl: "مطعم ابو بكر", addShopLbl: .none, btnTaG: "مطعم", trashIcon: "red_trash")]

    var addNewShop:[AddShop] = [AddShop(imageFrame: .none, imageIconAdd: "iconfinder_add_134224", shopLbl: .none, addShopLbl: "اضافة محل اخر", btnTaG: .none, trashIcon: .none)]
    
    var contentIndex : Int!
    var shopAdded:[MyStores.Datum] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
        setup()
        fetchCategories()

        
    }
    func setup() {
        tableViewB.delegate = self
        tableViewB.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self

    }
    func fetchCategories() {
        startLoading()
        ApiManager.instance.connection(.stores, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(MyStores.self, from: response ?? Data())
                self?.shopAdded.append(contentsOf: data?.data ?? [])
                self?.tableViewB.reloadData()
            print("CategriesBySectionId")
        }
    }
    
    
    func customInit(contentIndex:Int,title:String) {

        self.contentIndex = contentIndex
        self.title = title

    }
}
extension AddShopVC: UITableViewDelegate,UITableViewDataSource{

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
        cell2.imageIcon.setImage(url: shopAdded[indexPath.row].image!)
        cell2.shopsTitleAdd.text = shopAdded[indexPath.row].name
        cell2.shopsTag.setTitle("\(shopAdded[indexPath.row].catName)", for: .normal)
        cell2.ratingView.rating = Double(shopAdded[indexPath.row].rate!)
        cell2.trash.tag = indexPath.row
//        cell2.trash.addTarget(self, action: selector(("Trash")), for: .touchUpInside)
         return cell2
    }
//    @objc func Trash(){
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //performSegue(withIdentifier: Segues.ToAddShopDetails, sender: self)

    }

}
