//
//  countryViewController.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class CountryViewController: BaseController {
    @IBOutlet weak var countyTableView: UITableView!
    @IBOutlet weak var languageButtton1: RoundedButton!
    @IBOutlet weak var languageButtton2: RoundedButton!
    
    
    var countries: [Country.CountryData] = []
    var selectedCountry: Int?
    var selectedLang: String?
    static var deviceCountry: Country.CountryData? {
        set {
            guard let value = newValue else { return }
            let data = try? JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: "COUNTRY_DATA")
        } get {
            let data = UserDefaults.standard.data(forKey: "COUNTRY_DATA")
            let model = try? JSONDecoder().decode(Country.CountryData.self, from: data ?? Data())
            return model
        }
    }
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
        fetchCountries()
    }
    func setup() {
        countyTableView.dataSource = self
        countyTableView.delegate = self
    }
    func fetchCountries() {
        startLoading()
        //ApiManager.instance.paramaters[] =
        ApiManager.instance.connection(.MainCountry, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Country.self, from: response ?? Data())
            if case data?.status = true {
                self?.countries.append(contentsOf: data?.data ?? [])
                self?.countyTableView.reloadData()
            }
        }
    }
    @IBAction func onLanguageButtonTapped(_ sender: Any) {
        languageButtton1.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        languageButtton2.backgroundColor = .white
        selectedLang = "ar"

    }
    
    @IBAction func onLanguageButtonTapped2(_ sender: Any) {
        languageButtton2.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        languageButtton1.backgroundColor = .white
        selectedLang = "en"
    }
    @IBAction func apply(_ sender: Any) {
        Localizer.set(language: selectedLang ?? "ar")
        CountryViewController.deviceCountry = countries[selectedCountry ?? 0]
        let vc = controller(LoginVC.self, storyboard: .auth)
        push(vc)
        
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: CountryTableViewCell.self, indexPath, register: false)
        cell.model = countries[indexPath.row]
        if selectedCountry == indexPath.row {
            cell.backgroundImageView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        } else {
            cell.backgroundImageView.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
        }
        
        cell.onClick = { [unowned self] in
             cell.backgroundImageView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
             self.selectedCountry = indexPath.row
         tableView.reloadData()
        }
        
        return cell
                                        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
