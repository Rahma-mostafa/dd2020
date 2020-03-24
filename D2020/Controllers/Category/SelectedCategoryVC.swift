//
//  SelectedCategoryVC.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
struct  ItemdidSelected {
    var didSelectedName:String?
    var didSelecedImageName:String?
    var didSelectedKm:String?
}
class SelectedCategoryVC: BaseController {
    @IBOutlet weak var titleLabel: NSLayoutConstraint!
    @IBOutlet weak var allShopsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    
    var category:Int? = 47
    var didSelectedItems:[ShopsByCatID.Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
         setup()
        fetchShopsByCatID()
     
    }
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func fetchShopsByCatID() {
       startLoading()
        let method = api(.shop , [category ?? 0] )
       ApiManager.instance.headers["cat_id"] = "\(category ?? 0)"
       ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
              self?.stopLoading()
              print("run")
              let data = try? JSONDecoder().decode(ShopsByCatID.self, from: response ?? Data())
              self?.didSelectedItems.append(contentsOf: data?.data ?? [])
                  self?.tableView.reloadData()
              print("subCategory")
          }
      }
    
    
    @IBAction func onOptionButtonTapped(_ sender: Any) {
        showTable()
    }
    
    @IBAction func onChooseButtonTapped(_ sender: Any) {
        showCityTable()
    }
    
}

extension SelectedCategoryVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 100
           }
       
       
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return didSelectedItems.count
          }
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.SelectedCategory , for: indexPath) as! SelectedCategoryCell
           
           cell.didSelectedImg.setImage(url: didSelectedItems[indexPath.row].image!)
           
            cell.didSelectedTitle.text = didSelectedItems[indexPath.row].name
           
            cell.didSelectedKm.text = didSelectedItems[indexPath.row].distance
            cell.starView.rating = Double(didSelectedItems[indexPath.row].rate!)
             cell.saveButton.tag = indexPath.row
                          self.setupFavorite(change: false, sender: cell.saveButton)
                          cell.saveButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
                          return cell
                  }
                   @objc func buttonClicked(sender:UIButton){
                              let method = api(.getSubCategoryAndShop, [self.shopArray[sender.tag].id!])
                              ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
                               self?.setupFavorite(change: true ,sender: sender)
                              }
                   }
                   func setupFavorite(change: Bool ,sender: UIButton ) {
                       if case change = true {
                           if case self.shopArray[sender.tag].isFavorite = true  {
                               self.shopArray[sender.tag].isFavorite = false
                           } else {
                               self.shopArray[sender.tag].isFavorite = true
                           }
                   }
                   if case self.shopArray[sender.tag].isFavorite = true  {
                       sender.setImage(UIImage(named: "save_act"), for: .normal)
                   } else {
                       sender.setImage(UIImage(named: "save"), for: .normal)
                   }
               }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //performSegue(withIdentifier: Segues.ToProfileVC, sender: self)
       }
    
    private func showTable(){
        let vc = controller(OptionViewController.self, storyboard: .pop)
            vc.shouldHideTable = { [unowned self]
                    (Name) in
                    self.hideTable()
            }
            self.pushPop(vcr: vc)
                   
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
        
        func hideTable(){
            tableHeightConstraint.constant = 0
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
                      let optionViewController = segue.destination as! OptionViewController
                      optionViewController.shouldHideTable = { [unowned self] (Name) in
                          self.hideTable()
                          //Set Name Here
                      }
                  }else if segue.identifier == "ChangeCityTableSegue"{
                       let changeCityViewController = segue.destination as! ChangeCityViewController
                       changeCityViewController.shouldHideTable = { [unowned self]
                           (Name) in
                           self.hideCityTable()
                           self.cityTextField.text = Name
                       }
                  }
              }
                
                 
            
            

}
    
    
    
    
    
    
    
    
    
    


