//
//  newCustomer.swift
//  D2020
//
//  Created by Macbook on 2/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire



class newCustomer: BaseController{
   
    
    @IBOutlet weak var ChangeCityTableSegue: NSLayoutConstraint!
    
    @IBOutlet weak var cityTextField: UITextField!
    //Variables
  
    let height :CGFloat = 250
//    let cities = ["Geedah","Riadah","Kasim"]
//    var pickerView = UIPickerView()
    
    
    var isSecure = true
    
    
    var registerType : RegisterAs.RegisterAsData?
    
//    var section:Int? = 14
    var Country:Int? = 27
//    var cityArray:[City.CitySmall] = []



    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var selectCity: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var coloredButton: RoundedButton!
    
    @IBOutlet weak var coloredView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        selectCity.inputView = pickerView
        selectCity.textAlignment = .center

//        pickerView.delegate = self
//        pickerView.dataSource = self
        
//        fetchCity()
        
        if registerType?.style == 1 {
            
            self.title = "مستاجر جديد"
            navigationController?.navigationBar.barTintColor = UIColor(red: 71/255.0, green: 173/255.0, blue: 173/255.0, alpha: 1.0)
                        
                        coloredView.layer.backgroundColor = CGColor(srgbRed: 71/255.0, green: 173/255.0, blue: 173/255.0, alpha: 1.0)

            
            coloredButton.layer.backgroundColor = CGColor(srgbRed: 71/255.0, green: 173/255.0, blue: 173/255.0, alpha: 1.0)
            
                        
            guard let font = UIFont(name: "Sukar", size: 26)else{return}
                   navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:font]
                        
        }else if registerType?.style == 2 {
            self.title = "صاحب محل"
            guard let font = UIFont(name: "Sukar", size: 26)else{return}
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:font]
        }else if registerType?.style == 3 {
            self.title = "المندوب"
           navigationController?.navigationBar.barTintColor = UIColor(red: 36/255.0, green: 155/255.0, blue: 210/255.0, alpha: 1.0)
            
            coloredView.layer.backgroundColor = CGColor(srgbRed: 36/255.0, green: 155/255.0, blue: 210/255.0, alpha: 1.0)

            coloredButton.layer.backgroundColor = CGColor(srgbRed: 36/255.0, green: 155/255.0, blue: 210/255.0, alpha: 1.0)
            
guard let font = UIFont(name: "Sukar", size: 26)else{return}
       navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:font]
            
            
        }else if registerType?.style == 4 {
            self.title = "الاسرة المنتجة"
            navigationController?.navigationBar.barTintColor = UIColor(red:  225/255.0, green: 61/255.0, blue: 70/255.0, alpha: 1.0)
                         
                         coloredView.layer.backgroundColor = CGColor(srgbRed: 225/255.0, green: 61/255.0, blue: 70/255.0, alpha: 1.0)

            
            coloredButton.layer.backgroundColor = CGColor(srgbRed: 225/255.0, green: 61/255.0, blue: 70/255.0, alpha: 1.0)
                         
             guard let font = UIFont(name: "Sukar", size: 26)else{return}
                    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:font]
        }
        

        
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
    
    @IBAction func onCodeButtonTapped(_ sender: Any) {
//        showCityTable()
        
    }
    
    
    
//    func fetchCity() {
//            startLoading()
//        let method = api(.SubCountry , [Country ?? 0])
//              ApiManager.instance.headers["Country_id"] =  "\( Country ?? 0)"
//              ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
//                self?.stopLoading()
//                let data = try? JSONDecoder().decode(City.self, from: response ?? Data())
//                    self?.cityArray.append(contentsOf: data?.data ?? [])
//                    
//
//            }
//    }
    
    
    private func showCityTable(){
    let vc = controller(ChangeCountryViewController.self, storyboard: .pop)
        vc.shouldHideTable = { [unowned self]
            (Name) in
            self.hideCityTable()
            self.cityTextField.text = Name
        }
        self.pushPop(vcr: vc)
    }
    func hideCityTable(){
    ChangeCityTableSegue.constant = 0
       UIView.animate(withDuration: 0.5) {[unowned self] in
          self.view.layoutIfNeeded()
        self.dismiss(animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeCityTableSegue"{
                 let changeCityViewController = segue.destination as! ChangeCityViewController
                 changeCityViewController.shouldHideTable = { [unowned self]
                     (Name) in
                     self.hideCityTable()
                     self.cityTextField.text = Name
                 }
            }
        }
    
    
    
    

//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return cities.count
//       }
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return cities[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectCity.text = cities[row]
//        selectCity.resignFirstResponder()
//    }
    
    @IBAction func NextTapped(_ sender: Any) {
        
        // if no text entered
        if fullName.text!.isEmpty || password.text!.isEmpty || confirmPassword.text!.isEmpty || email.text!.isEmpty || selectCity.text!.isEmpty  {
                     
                       // red placeholders
                    phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                    password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                       
                   // text is entered
                   } else {
                       
                       // remove keyboard
                       self.view.endEditing(true)
            
                    guard let phone = phoneNumber.text, !phoneNumber.text!.isEmpty else {return}
                    guard let password = password.text, !password.isEmpty else {return}
                     guard let confirmPass = confirmPassword.text, !confirmPassword.text!.isEmpty else {return}
            
            guard let name = fullName.text, !fullName.text!.isEmpty else {return}
            
            guard let emailAddress = email.text, !email.text!.isEmpty else {return}
            
            guard let selectingCity = selectCity.text, !selectCity.text!.isEmpty else {return}
            
            API.regisetr(phone: phone, email: emailAddress, name: name, password: password, confirmPassword: confirmPass) { (error:Error?,success: Bool) in
                            if success {
                                
                                //go to homeView
                          
                            
                            
                            }else{
                                
                                //make a popview error
                                
                                
                                
                                
                            }
                            
                        }
                
                

            }
            }
}
