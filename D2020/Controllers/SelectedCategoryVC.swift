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
class SelectedCategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    var didSelectedItems:[ItemdidSelected] = [ItemdidSelected(didSelectedName: "كافيه الغروب", didSelecedImageName: "maksim-zhashkevych-qXfLGt9nh2Y-unsplash", didSelectedKm: "12K.M"),ItemdidSelected(didSelectedName: "مطعم ابو بكر", didSelecedImageName: "irina-89UsTc5bjsw-unsplash", didSelectedKm: "2K.M"),ItemdidSelected(didSelectedName: "pizza hot", didSelecedImageName: "carissa-gan-_0JpjeqtSyg-unsplash", didSelectedKm: "20K.M")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return didSelectedItems.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.SelectedCategory , for: indexPath) as! SelectedCategoryCell
        
        cell.didSelectedImg.image = UIImage(named: didSelectedItems[indexPath.row].didSelecedImageName!)
        
        cell.didSelectedTitle.text = didSelectedItems[indexPath.row].didSelectedName
        
        cell.didSelectedKm.text = didSelectedItems[indexPath.row].didSelectedKm
               return cell
           }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.ToProfileVC, sender: self)
    }
    
    @IBAction func onOptionButtonTapped(_ sender: Any) {
        showTable()
    }
    
    @IBAction func onChooseButtonTapped(_ sender: Any) {
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
