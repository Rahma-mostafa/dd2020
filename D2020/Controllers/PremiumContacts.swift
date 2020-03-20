//
//  PremiumContacts.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit


struct PremiumCommunication {
    var contactImage :String?
    var contactTitle :String?
    var coloreView:UIColor?
    var contactName:String?
}

class PremiumContacts: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var premiumCommunicate:[PremiumCommunication] = [PremiumCommunication(contactImage: "twitter (8)", contactTitle: "حساب تويتر", coloreView: .systemBlue),PremiumCommunication(contactImage: "facebook", contactTitle: "حساب الفيس بوك", coloreView : .gray),PremiumCommunication(contactImage: "whatsapp", contactTitle: "رقم الواتس", coloreView: .green),PremiumCommunication(contactImage: "instagram", contactTitle: "حساب الانستجرام", coloreView: .systemPink),PremiumCommunication(contactImage: "snapchat", contactTitle: "حساب السناب شات", coloreView: .systemYellow),PremiumCommunication(contactImage: "internet", contactTitle: "الموقع الالكتروني", coloreView: .systemGreen)]
    
    
    @IBOutlet weak var Tb: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Tb.delegate = self
        Tb.dataSource = self

        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 90
           }
       
       
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return premiumCommunicate.count
          }
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.PremiumContacts , for: indexPath) as! PremiumContactsCell
           
            cell.contactImage.image = UIImage(named: premiumCommunicate[indexPath.row].contactImage!)
           
            cell.contactName.text = premiumCommunicate[indexPath.row].contactTitle
           
            cell.coloredView.backgroundColor = premiumCommunicate[indexPath.row].coloreView
                  return cell
              }
    

   
    
    
    
    
    

}
