//
//  CategoryVC.swift
//  D2020
//
//  Created by Macbook on 2/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct Item {
    var name:String?
    var imageName: String?
    var description: String?
    var imageIcon : String?
    var coloredView:UIColor?
    
}

struct SubCategory {
    var name:String?
    var imageName: String?
    var description: String?
}

class CategoryVC: UIViewController{
    
    
    var categoriesB : [Item] = [Item(name: "المحلات الخاصة بي", imageName: "online-store (1)", description: .none, coloredView: .none)]
    
    
//    var selectedCategory : String?
    var categories = [Item]()
    var items : [Item] = [Item(name: "مطاعم وكافيهات", imageName: "food", description: "اكثر من ٩٠ مطعم وكافيه",coloredView: .none),Item(name: "التسوق", imageName: "shopping-cart", description: "اكثر من ١٥٠ سوبرمازكت",coloredView: .none),Item(name: "الازياء والملابس", imageName: "shirt", description: "اكثر من ٧٠ محل ملابس",coloredView: .none),Item(name: "مراكز تجميل", imageName: "Flat", description: "اكثر من ٩٠ مركز تجميل",coloredView: .none),Item(name: "سياحة وفنادق", imageName: "hotel", description: "اكثر من ٩٠ فندق وكافيه",coloredView: .none),Item(name: "الكترونيات", imageName: "game-controller", description: "اكثر من ٩٠ محل الكتروني",coloredView: .none),Item(name: "هدايا وعطور", imageName: "Flat1", description: "اكثر من ٩٠ محل للهدايا",coloredView: .none),Item(name: "خدمات", imageName: "tools", description: "اكثر من ٩٠  خدمة مثل : السباكة ..الخ ",coloredView: .none),Item(name: "صيانة وتصليح", imageName: "Group 107", description: "اكثر من ٩٠ محل صيانة للسيارات وغيرها",coloredView: .none),Item(name: "جمعيات خيرية", imageName: "heart", description: "اكثر من ٩٠ محل صيانة للسيارات وغيرها",coloredView: .none)]
    
    
    
    
    
    
    
    
//       //(17)->da mot3'ir l method l didSelect Item 34an y3rfny anhy cell dosna 3leha
//          var selectedProduct : Product!
       
    
    var item = [Item]()
    
//    var selectedProduct : Product!
    
    
//    var products = [Product]()
    var category : Category!
    


    
    @IBOutlet weak var tableViewB: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewB.dataSource = self
        tableViewB.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func onCityButtonTapped(_ sender: Any) {
        showCityTable()
    }
    
}
    
extension CategoryVC : UITableViewDelegate,UITableViewDataSource {
   
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
           return categoriesB.count
        }
        return items.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell,for:indexPath) as! ProductCell
            
            
            
            cell.categoryTitleB.text = categoriesB[indexPath.row].name
            cell.categoryImgB.image = UIImage(named: categoriesB[indexPath.row].imageName!)
            
            
            return cell
        }
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier:Identifiers.ProductCell , for: indexPath) as! ProductCell
        
        cell2.categoryImg.image = UIImage(named: items[indexPath.row].imageName!)
        
        cell2.categoryTitle.text = items[indexPath.row].name
        
        cell2.categoryDesc.text = items[indexPath.row].description
               return cell2
           }
          

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let vc = EachCategoryVC()
//        let selectedCategory = item[indexPath.row]
//        selectedCategory = item[indexPath.row]
//        selectedCategory = items[indexPath.row].description
//        vc.category = selectedCategory
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: true, completion: nil)
        
        
        let productVC = AddShopVC()
        
        
        if tableView == self.tableView {
            performSegue(withIdentifier: Segues.ToMyShops
                , sender: self)
        
    }
        performSegue(withIdentifier: "toEachCategory", sender: self)
 
}
    
    private func showCityTable(){
                 changeCityHeightConstraint.constant = self.view.frame.height + 20
                     UIView.animate(withDuration: 0.5) {[unowned self] in
                         self.view.layoutIfNeeded()
                     }
                 }
    func hideCityTable(){
    changeCityHeightConstraint.constant = 0
       UIView.animate(withDuration: 0.5) {[unowned self] in
          self.view.layoutIfNeeded()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeCityTableSegue"{
                 let changeCityViewController = segue.destination as! changeCityViewController
                 changeCityViewController.shouldHideTable = { [unowned self]
                     (Name) in
                     self.hideCityTable()
                     self.cityTextField.text = Name
                 }
            }
        }
    
    
    
    
    
    
    
    
}
