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

class PremiumContacts: BaseController {
    
    
    @IBOutlet weak var contactsLbl: UILabel!
    @IBOutlet weak var contactsTbl: UITableView!
    
    var premiumCommunicate:[PremiumCommunication] = [
        PremiumCommunication(contactImage: "twitter (8)", contactTitle: Localizations.twitter.localized, coloreView: UIColor(red: 3, green: 169, blue: 244, alpha: 1)) ,
        PremiumCommunication(contactImage: "facebook", contactTitle: Localizations.facebook.localized, coloreView : UIColor(red: 66, green: 103, blue: 178, alpha: 1)),
        PremiumCommunication(contactImage: "whatsapp", contactTitle: Localizations.whatsapp.localized, coloreView: UIColor(red: 76, green: 175, blue: 80, alpha: 1)) ,
        PremiumCommunication(contactImage: "instagram", contactTitle: Localizations.instagram.localized, coloreView: UIColor(red: 244, green: 78, blue: 86, alpha: 1)) ,
        PremiumCommunication(contactImage: "snapchat", contactTitle: Localizations.snapchat.localized, coloreView: UIColor(red: 255, green: 233, blue: 36, alpha: 1)),
        PremiumCommunication(contactImage: "internet", contactTitle: Localizations.website.localized, coloreView: UIColor(red: 72, green: 177, blue: 155, alpha: 1))
    ]
    
    
    static weak var instance: PremiumContacts?
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
        PremiumContacts.instance = self
    }
    func setup() {
        contactsLbl.text = Localizations.contactsMethod.localized
        contactsTbl.delegate = self
        contactsTbl.dataSource = self
    }
    func reload() {
        contactsTbl.reloadData()
    }
    
}
extension PremiumContacts: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return premiumCommunicate.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.PremiumContacts , for: indexPath) as! PremiumContactsCell
        
        cell.contactImage.image = UIImage(named: premiumCommunicate[indexPath.row].contactImage!)
        
        cell.contactName.text = premiumCommunicate[indexPath.row].contactTitle
        
        switch indexPath.row {
            case 0:
                cell.coloredView.backgroundColor = .appBlue
            case 1:
                cell.coloredView.backgroundColor = .blue

            case 2:
                cell.coloredView.backgroundColor = .appGreen

            case 3:
                cell.coloredView.backgroundColor = .appRed

            case 4:
                cell.coloredView.backgroundColor = .yellow

            case 5:
                cell.coloredView.backgroundColor = .websiteColor

            default:
                break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                openUrl(text: StorePremuimController.storePrem?.facebook)
            case 1:
                openUrl(text: StorePremuimController.storePrem?.facebook)

            case 2:
                let url  = URL(string: "whatsapp://send?phone=\(StorePremuimController.storePrem?.whatsapp ?? "")&abid=12354&text=D2020")
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:]) { (success) in
                        if success {
                            print("WhatsApp accessed successfully")
                        } else {
                            print("Error accessing WhatsApp")
                        }
                    }
                }
                openUrl(text: StorePremuimController.storePrem?.whatsapp)

            case 3:
                openUrl(text: StorePremuimController.storePrem?.instagram)

            case 4:
                openUrl(text: StorePremuimController.storePrem?.snap)

            case 5:
                openUrl(text: StorePremuimController.storePrem?.website)

            default:
            break
        }
    }
}
