//
//  EachCategoryVC.swift
//  D2020
//
//  Created by Macbook on 2/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit



struct ItemSelected {
    var selectedname: String?
    var ImageSelectedName : String?
    var kmPassedSelected : String?
    var logoPremium:String?
    
}

struct ItemSubCategory {
    var name: String?
    var imageName : String?
}

class EachCategoryVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    var category : Item!
    
    //    var categories = [Category]()
    var selectedCategory : String?
    
    var itemsSelected:[ItemSelected] = [ItemSelected(selectedname: "كافيه الغروب", ImageSelectedName: "maksim-zhashkevych-qXfLGt9nh2Y-unsplash", kmPassedSelected: "12.5 K.M",logoPremium: "mmmmm"),ItemSelected(selectedname: "مطعم ابو بكر", ImageSelectedName: "irina-89UsTc5bjsw-unsplash", kmPassedSelected: "13 K.M",logoPremium: ""),ItemSelected(selectedname: "Pizza Hot", ImageSelectedName: "carissa-gan-_0JpjeqtSyg-unsplash", kmPassedSelected: "10K.M",logoPremium: "")]
    
    
    var items:[ItemSubCategory] = [ItemSubCategory(name: "كافيه", imageName: "jeremy-ricketts-6ZnhM-xBpos-unsplash"),ItemSubCategory(name: "مطعم ", imageName: "toa-heftiba-vqTkZZ1JtOU-unsplash"),ItemSubCategory(name: "فئة ٣", imageName: "piotr-miazga-WBX-ZLr8P7I-unsplash"),ItemSubCategory(name: "فئة ٤", imageName: "chad-montano-MqT0asuoIcU-unsplash"),ItemSubCategory(name: "فئة ٥", imageName: "food")]
    
    
    
 
      
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: Identifiers.SubCategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.SubCategoryCell)
        

        // Do any additional setup after loading the view.
    }
    
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 100
            }
        
    
    
        
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
               return itemsSelected.count
        
           
    }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           
                
                
                
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.AfterSelectingCell , for: indexPath) as! AfterSelectingCell
            
             cell.imageSelected.image = UIImage(named: itemsSelected[indexPath.row].ImageSelectedName!)
            
            cell.premiumLogo.image = UIImage(named: itemsSelected[indexPath.row].logoPremium!)
            
            cell.titleSelected.text = itemsSelected[indexPath.row].selectedname
            
            cell.kmSelected.text = itemsSelected[indexPath.row].kmPassedSelected
                   return cell
            
            
    }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
            //performSegue(withIdentifier: Segues.ToPremium, sender: self)
            
        }
    
    @IBAction func onOptionButtonTapped(_ sender: Any) {
        showTable()
    }
    
    @IBAction func onChooseButtonClick(_ sender: Any) {
        showCityTable()
    }
    
    private func showTable(){
        tableHeightConstraint.constant = self.view.frame.height + 20
//        changeCityHeightConstraint.constant = self.view.frame.height + 20
            UIView.animate(withDuration: 0.5) {[unowned self] in
                self.view.layoutIfNeeded()
            }
        }
    private func showCityTable(){
           changeCityHeightConstraint.constant = self.view.frame.height + 20
               UIView.animate(withDuration: 0.5) {[unowned self] in
                   self.view.layoutIfNeeded()
               }
           }
    
    func hideTable(){
        tableHeightConstraint.constant = 0
//        changeCityHeightConstraint.constant = 0
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
           if segue.identifier == "OptionTableSegue"{
               let optionViewController = segue.destination as! optionViewController
               optionViewController.shouldHideTable = { [unowned self] (Name) in
                   self.hideTable()
                   //Set Name Here
               }
           }else if segue.identifier == "ChangeCityTableSegue"{
                let changeCityViewController = segue.destination as! changeCityViewController
                changeCityViewController.shouldHideTable = { [unowned self]
                    (Name) in
                    self.hideCityTable()
                    self.cityTextField.text = Name
                }
           }
       }
       
    
    


}

extension EachCategoryVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.SubCategoryCell, for: indexPath) as? SubCategoryCell
        
        
        cell?.subCategoryImg.image = UIImage(named: items[indexPath.item].imageName!)
        
        cell?.subCategoryTitle.text = items[indexPath.item].name
        
        
        return cell!
           }
          
       //(10) d lly btt7km f 7gm l cell lyy htt3rdly 7sb 7gm l telephone lly h3rd 3leh
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               
           //bt3rd l width bta3 l mobile
               let width = view.frame.width
               //(11) moheeeeemaaaaa ->na2s 30 34an 3ndi 10 3lymen w 10 3l 4mal w 10 l min soacing fhib2o 30 lly homa m4 mst5dmnhom,y3ni hn5li l width bta3 l collectionView m2som 3la 5lyten bs y3ni hn3rd 5lyten hna bs f msa7a l collectionView kolha
               let cellWidth = (width - 50) / 4
            let cellHeight = cellWidth * 1.5
               
           return CGSize(width: cellWidth, height: cellHeight)
           
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategory = items[indexPath.item].name
        selectedCategory = items[indexPath.item].imageName
        
       
//        selectedCategory = items[indexPath.item].name
//
//        selectedCategory = items[indexPath.item].imageName
//
//
////        selectedCategory = UIImage(named: categoryimages[indexPath.item])
//
        //performSegue(withIdentifier: Segues.ToSelectedCategory, sender: self)

        }
    
    
  
}
