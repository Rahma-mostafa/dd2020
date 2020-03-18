//
//  NewAdsMan.swift
//  D2020
//
//  Created by Macbook on 2/24/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class NewAdsMan: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var isSecure = true
    
    
    let height :CGFloat = 250
    let cities = ["Geedah","Riadah","Kasim"]
    var pickerView = UIPickerView()


    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var selectCity: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
