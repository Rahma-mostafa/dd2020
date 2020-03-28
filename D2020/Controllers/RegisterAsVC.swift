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

class RegisterAsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    //Variables Of RegisterAs TableView
    
    var registerAS:[tableViewRegister] = [tableViewRegister(img: "user", title: "مستخدم جديد"),tableViewRegister(img: "delegate", title: "مندوب جديد"),tableViewRegister(img: "online-store (1)", title:"تاجر جديد"),tableViewRegister(img: "calendar", title: "معلن جديد"),tableViewRegister(img: "team", title: "اسرة منتجة")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return registerAS.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.RegisterTableView , for: indexPath) as! RegisterTableViewCell
        cell.imgRegister.image = UIImage(named: registerAS[indexPath.row].img!)
        
        cell.titleRegister.text = registerAS[indexPath.row].title
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

