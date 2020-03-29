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
class CategoryVC: BaseController {
    
    @IBOutlet weak var titleLabel: UIBarButtonItem!
    @IBOutlet weak var tableViewB: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoriesTblTop: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cloudView: UIView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var imageStyle: UIImageView!
    
    var categoriesB : [Item] = [Item(name: "my.stores.lan".localized, imageName: "online-store (1)", description: .none, coloredView: .none)]
    var category : Category!
    var categoryArray:[Category.DateElement] = []
    var section: Int?
    var sectionName: String?
    var city_id: Int?
    var style: Style = .green
    var styleGrediantImage: String = "orangeGrad"
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = sectionName
        setupStyle()
        setup()
        fetchCategories()
    }
    
    func setup() {
        tableViewB.dataSource = self
        tableViewB.delegate = self
        
    }
    func setupStyle() {
        switch style {
        case .orange:
            self.navigationController?.navigationBar.barTintColor = .appOrange
            self.view.backgroundColor = .appOrange
            self.styleGrediantImage = "orangeGrad"
            self.cloud1.image = UIImage(named: "cloudOrange")
            self.cloud2.image = UIImage(named: "cloudOrange1")
            self.circle.image = UIImage(named: "circleOrange")
            self.imageStyle.image = UIImage(named: "online-store (1)")
        case .green:
            self.navigationController?.navigationBar.barTintColor = .appGreen
            self.view.backgroundColor = .appGreen
            self.styleGrediantImage = "greenGrad"
            self.cloud1.image = UIImage(named: "cloudGreen")
            self.cloud2.image = UIImage(named: "cloudGreen1")
            self.circle.image = UIImage(named: "circleGreen")
            self.imageStyle.image = UIImage(named: "calendarGreen")
            break
        case .red:
            self.navigationController?.navigationBar.barTintColor = .appRed
            self.view.backgroundColor = .appRed
            self.styleGrediantImage = "redGrad"
            self.cloud1.image = UIImage(named: "cloudRed")
            self.cloud2.image = UIImage(named: "cloudRed1")
            self.circle.image = UIImage(named: "circleRed")
            self.imageStyle.image = UIImage(named: "teamRed")
        }
    
    }
    func fetchCategories() {
        startLoading()
        let method = api(.getCategory, [section ?? 0])
        ApiManager.instance.headers["section_id"] = "\(section ?? 0)"
        if city_id != nil {
            ApiManager.instance.paramaters["city_id"] = "\(city_id ?? 0)"
        }
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(Category.self, from: response ?? Data())
            if case data?.userPermission = false {
                self?.categoriesB.removeAll()
                self?.categoriesTblTop.constant = 15
            } else {
                self?.tableView.delegate = self
                self?.tableView.dataSource = self
                self?.tableView.reloadData()
            }
            self?.categoryArray.append(contentsOf: data?.date ?? [])
            self?.tableViewB.reloadData()
            print("CategriesBySectionId")
        }
    }
    @IBAction func onCityButtonTapped(_ sender: Any) {
        showCityTable()
    }
}


extension CategoryVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
            cell.categoryImgB.image = self.imageStyle.image
            cell.imageGradient.image = UIImage(named: styleGrediantImage)
            return cell
        }
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier:Identifiers.ProductCell , for: indexPath) as! ProductCell
        cell2.categoryImg.setImage(url: categoryArray[indexPath.row].image)
        cell2.categoryTitle.text = categoryArray[indexPath.row].name
        cell2.categoryDesc.text = "\(categoryArray[indexPath.row].desc ?? "")"
        
        return cell2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.tableView {
            let scene = controller(MyShopsVC.self, storyboard: .createStore)
            navigationController?.pushViewController(scene, animated: true)
        }else {
            let scene = controller(EachCategoryVC.self, storyboard: .category)
            scene.style = style
            scene.section = categoryArray[indexPath.row].id
            scene.selectedCategory = categoryArray[indexPath.row].name
            
            push(scene)
        }
        
    }
    
    private func showCityTable(){
        let vc = controller(ChangeCityViewController.self, storyboard: .pop)
        vc.shouldHideTable = { [unowned self]
            (Name, id) in
            self.hideCityTable()
            self.cityTextField.text = Name
            self.city_id = id
            self.fetchCategories()
        }
        self.pushPop(vcr: vc)
    }
    func hideCityTable(){
        changeCityHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
}

