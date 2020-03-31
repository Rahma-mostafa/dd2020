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
    var selectedCountry: Country.CountryData? = CountryViewController.deviceCountry
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        selectCity.inputView = pickerView
        cityTextField.textAlignment = .center
        self.title = registerType?.registerLike
        self.enterDataLbl.text = "enter.data.lan".localized
        self.nextBtn.setTitle("next.lan".localized, for: .normal)
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
                self.countries[row].image ?? ""
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
    func validate() -> Bool {
        if case fullName.text?.isEmpty = true {
            fullName.attributedPlaceholder = NSAttributedString(string: fullName.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case phoneNumber.text?.isEmpty = true {
            phoneNumber.attributedPlaceholder = NSAttributedString(string: phoneNumber.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case email.text?.isEmpty = true {
            email.attributedPlaceholder = NSAttributedString(string: email.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case cityTextField.text?.isEmpty = true {
            cityTextField.attributedPlaceholder = NSAttributedString(string: cityTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case password.text?.isEmpty = true {
            password.attributedPlaceholder = NSAttributedString(string: password.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case confirmPassword.text?.isEmpty = true {
            confirmPassword.attributedPlaceholder = NSAttributedString(string: confirmPassword.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        return true
    }
    @IBAction func NextTapped(_ sender: Any) {
        if validate() {
            // remove keyboard
            self.view.endEditing(true)
            
            let paramters: [String: Any] = [
                "phone": phoneNumber.text ?? "",
                "email": email.text ?? "",
                "name": fullName.text ?? "",
                "city_id": cities[selectedCity ?? 0].id ?? 0,
                "SectionsId": registerType?.id ?? 14,
                "country_code": selectedCountry?.code ?? 0,
                "password": password.text ?? "",
                "password_confirmation": confirmPassword.text ?? ""
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

