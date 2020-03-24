//
//  CategoryVC.swift
//  D2020
//
//  Created by Macbook on 2/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire


struct Item {
    var name:String?
    var imageName: String?
    var description: String?
    var imageIcon : String?
    var coloredView:UIColor?

}
class CategoryVC: BaseController{
    
    
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableViewB: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    
    var categoriesB : [Item] = [Item(name: "المحلات الخاصة بي", imageName: "online-store (1)", description: .none, coloredView: .none)]
       var category : Category!
       var categoryArray:[Category.DateElement] = []
       var section:Int? = 14
       var city_id:Int? = 27
      
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hiddenNav = true
        setup()
        fetchCategories()
    }
    
    func setup() {
        tableViewB.dataSource = self
        tableViewB.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchCategories() {
        startLoading()
        let method = api(.getCategory, [section ?? 0] )
        ApiManager.instance.headers["section_id"] = "\(section ?? 0)"
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(Category.self, from: response ?? Data())
                self?.categoryArray.append(contentsOf: data?.date ?? [])
                self?.tableViewB.reloadData()
            print("CategriesBySectionId")
        }
    }
    func fetchCategoriesByCityID() {
        startLoading()
        
        ApiManager.instance.headers["section_id"] = "\(section ?? 0 )"
        ApiManager.instance.paramaters["city_id"] = "\(city_id ?? 0)"
        let method = api(.getCategory , [section ?? 0] )
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(Category.self, from: response ?? Data())
                self?.categoryArray.append(contentsOf: data?.date ?? [])
                self?.tableViewB.reloadData()
            print("CategoriesByCityId")
        }
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
        return categoryArray.count
//        return 1
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell,for:indexPath) as! ProductCell
            cell.categoryTitleB.text = categoriesB[indexPath.row].name
            cell.categoryImgB.image = UIImage(named: categoriesB[indexPath.row].imageName!)
            return cell
        }
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier:Identifiers.ProductCell , for: indexPath) as! ProductCell
        cell2.categoryImg.setImage(url: categoryArray[indexPath.row].image)
        cell2.categoryTitle.text = categoryArray[indexPath.row].name
        cell2.categoryDesc.text = "\(categoryArray[indexPath.row].desc)"
        
               return cell2
           }
          

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let productVC = AddShopVC()
        
        
        if tableView == self.tableView {
           // performSegue(withIdentifier: Segues.ToMyShops, sender: self)
        
        }else {
           let storyboard = UIStoryboard(name: "Category", bundle: nil)
                  let scene = storyboard.instantiateViewController(withIdentifier: "EachCategoryVC")
                  navigationController?.pushViewController(scene, animated: true)

        }
 
    }
    
   private func showCityTable(){
    let vc = controller(ChangeCityViewController.self, storyboard: .pop)
        vc.shouldHideTable = { [unowned self]
            (Name) in
            self.hideCityTable()
            self.cityTextField.text = Name
        }
        self.pushPop(vcr: vc)
    }
    func hideCityTable(){
    changeCityHeightConstraint.constant = 0
       UIView.animate(withDuration: 0.5) {[unowned self] in
          self.view.layoutIfNeeded()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeCityTableSegue"{
                 let changeCityViewController = segue.destination as! ChangeCityViewController
                 changeCityViewController.shouldHideTable = { [unowned self]
                     (Name) in
                     self.hideCityTable()
                     self.cityTextField.text = Name
                    self.fetchCategoriesByCityID()
                 }
            }
        }
    
    
    
    
    
    
    
    
}
