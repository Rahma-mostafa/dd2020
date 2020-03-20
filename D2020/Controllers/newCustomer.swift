//
//  newCustomer.swift
//  D2020
//
//  Created by Macbook on 2/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit



class newCustomer: UIViewController
, UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    @IBOutlet weak var ChangeCityTableSegue: NSLayoutConstraint!
    
    @IBOutlet weak var cityTextField: UITextField!
    //Variables
  
    let height :CGFloat = 250
    let cities = ["Geedah","Riadah","Kasim"]
    var pickerView = UIPickerView()
    
    var isSecure = true



    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var selectCity: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCity.inputView = pickerView
        selectCity.textAlignment = .center

        pickerView.delegate = self
        pickerView.dataSource = self

        
    }
    
    @IBAction func showPassword1(_ sender: Any) {
           
        
           isSecure = !isSecure
                         password.isSecureTextEntry = isSecure
           
       }
       
       @IBAction func showPassword2(_ sender: Any) {
           
           isSecure = !isSecure
                         confirmPassword.isSecureTextEntry = isSecure
       }
    
    

    
  
    @IBAction func onCityButtonTapped(_ sender: Any) {
      showCityTable()
    }
    
    
    private func showCityTable(){
        ChangeCityTableSegue.constant = self.view.frame.height + 20
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
            }
    }
    func hideCityTable(){
    ChangeCityTableSegue.constant = 0
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
    
    
    
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
       }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCity.text = cities[row]
        selectCity.resignFirstResponder()
    }
    
    
 
}
