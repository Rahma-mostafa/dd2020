//
//  newCustomer.swift
//  D2020
//
//  Created by Macbook on 2/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire



class NewCustomer: BaseController{
    
    
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var enterDataLbl: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    //Variables
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var nextBtn: RoundedButton!
    
    let height :CGFloat = 250
    var isSecure = true
    var registerType : Section.Data?
    var cities: [CityModel.CityData] = []
    var countries: [Country.CountryData] = []
    var selectedCity: Int?
    var selectedCountry: Country.CountryData?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        selectCity.inputView = pickerView
        cityTextField.textAlignment = .center
        self.title = registerType?.registerLike
        fetchCities()
        fetchCountries()
        
        countryBtn.setTitle(CountryViewController.deviceCountry?.code, for: .normal)
        countryBtn.UIViewAction {
            let picker = self.controller(PickerPopVC.self, storyboard: .pop)
            picker.text = ""
            picker.source = self.countries
            picker.titleClosure = { row in
                 self.countries[row].name ?? ""
            }
            picker.imageClosure = { row in
                self.countries[row].file ?? ""
            }
            picker.didSelectClosure = { row in
                self.selectedCountry = self.countries[row]
                self.countryBtn.setTitle( self.countries[row].code, for: .normal)
            }
            self.pushPop(vcr: picker)
        }
    }
    func fetchCountries() {
        startLoading()
        ApiManager.instance.connection(.MainCountry, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Country.self, from: response ?? Data())
            if case data?.status = true {
                self?.countries.append(contentsOf: data?.data ?? [])
            }
        }
    }
    func fetchCities() {
        startLoading()
        let method = api(.SubCountry, [CountryViewController.deviceCountry?.id ?? 0])
        ApiManager.instance.connection(method, type: .get) { (response) in
            self.stopLoading()
            let data = try? JSONDecoder().decode(CityModel.self, from: response ?? Data())
            self.cities.append(contentsOf: data?.data ?? [])
        }
    }
    @IBAction func cityPick(_ sender: Any) {
        let picker = self.controller(PickerPopVC.self, storyboard: .pop)
        picker.text = Localizations.selectCity.localized
        picker.source = cities
        picker.titleClosure = { row in
            self.cities[row].name ?? ""
        }
        picker.didSelectClosure = { row in
            self.selectedCity = row
            self.cityTextField.text = self.cities[row].name
        }
        self.pushPop(vcr: picker)
    }
    
    @IBAction func showPassword1(_ sender: Any) {
        
        
        isSecure = !isSecure
        password.isSecureTextEntry = isSecure
        
    }
    
    @IBAction func showPassword2(_ sender: Any) {
        
        isSecure = !isSecure
        confirmPassword.isSecureTextEntry = isSecure
    }
    @IBAction func NextTapped(_ sender: Any) {
        
        // if no text entered
        if fullName.text!.isEmpty || password.text!.isEmpty || confirmPassword.text!.isEmpty || email.text!.isEmpty || cityTextField.text!.isEmpty  {
            
            // red placeholders
            phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number".localized, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            password.attributedPlaceholder = NSAttributedString(string: "password".localized, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            // text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            guard let phone = phoneNumber.text, !phoneNumber.text!.isEmpty else {return}
            guard let password = password.text, !password.isEmpty else {return}
            guard let confirmPass = confirmPassword.text, !confirmPassword.text!.isEmpty else {return}
            
            guard let name = fullName.text, !fullName.text!.isEmpty else {return}
            
            guard let emailAddress = email.text, !email.text!.isEmpty else {return}
            
            guard let selectingCity = cityTextField.text, !cityTextField.text!.isEmpty else {return}
         
            let paramters: [String: Any] = [
                "phone": phone,
                "email": emailAddress,
                "name": name,
                "city_id": cities[selectedCity ?? 0].id,
                "SectionsId": registerType?.id ?? 14,
                "country_code": selectedCountry?.code ?? 0,
                "password": password,
                "password_confirmation": confirmPass
            ]
            
            ApiManager.instance.paramaters = paramters
            startLoading()
            ApiManager.instance.connection(.register, type: .post) { (response) in
                self.stopLoading()
                let user = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                UserRoot.save(response: response)
                let vc = self.controller(CurrentLocationVC.self, storyboard: .auth)
                self.push(vc)
            }
        }
    }
}

