//
//  RegisterAsVC.swift
//  D2020
//
//  Created by Macbook on 3/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit


struct tableViewRegister {
    var img:String?
    var title:String?
}

class RegisterAsVC: BaseController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var registerAsLbl: UILabel!
    @IBOutlet weak var haveAccountLbl: UILabel!
    @IBOutlet weak var loginBtn: RoundedButton!
    
    
    //Variables Of RegisterAs TableView
    
    var registerAS:[tableViewRegister] = [tableViewRegister(img: "user", title: "مستخدم جديد"),tableViewRegister(img: "delegate", title: "مندوب جديد"),tableViewRegister(img: "online-store (1)", title:"تاجر جديد"),tableViewRegister(img: "calendar", title: "معلن جديد"),tableViewRegister(img: "team", title: "اسرة منتجة")]
    
    var sections: [Section.Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        var model = Section.Data()
//        model.id = 0
//        model.name = Localizations.newUser.localized
//        model.style = 0
//        sections.append(model)
        fetchSection()
    }
    func fetchSection() {
        let method = api(.getSections, [CountryViewController.deviceCountry?.id ?? 0])
        startLoading()
        ApiManager.instance.headers["Country_id"] = String(CountryViewController.deviceCountry?.id ?? 0)
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Section.self, from: response ?? Data())
            self?.sections.append(contentsOf: data?.data ?? [])
            self?.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.RegisterTableView , for: indexPath) as! RegisterTableViewCell
      
        cell.imgRegister.setImage(url: sections[indexPath.row].image)
        
        cell.titleRegister.text = sections[indexPath.row].name
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = controller(NewCustomer.self, storyboard: .auth)
        vc.registerType = self.sections[indexPath.row]
        push(vc)
    }
    
}


