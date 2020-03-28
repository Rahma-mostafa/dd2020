//
//  NotificationsVC.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct Notifications {
    var notificationImg: String?
    var notificationTitle : String?
    var notificationDetail : String?
    var notificationDate : String?
}

class NotificationsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
     var NotificationSelected:[Notifications] = [Notifications(notificationImg: "Box", notificationTitle: "هناك طلب مرسل لك", notificationDetail: "هل تم استلام طلبك", notificationDate: "منذ دقيقة"),Notifications(notificationImg: "Box", notificationTitle: "هناك طلب مرسل اليك", notificationDetail: "هل تم استلام طلبك", notificationDate: "منذ يومان"),Notifications(notificationImg: "Box", notificationTitle: "هناك طلب مرسل اليك", notificationDetail: "هل تم استلام طلبك", notificationDate: "منذ ٣ ايام")]
   
    
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NotificationSelected.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.NotificationsCell , for: indexPath) as! NotificationsCell
        
        cell.notificationsImg.image = UIImage(named: NotificationSelected[indexPath.row].notificationImg!)
        
        cell.notificationsTitle.text = NotificationSelected[indexPath.row].notificationTitle
        
        cell.notificationsDate.text = NotificationSelected[indexPath.row].notificationDate
        
        cell.notificationsDetails.text = NotificationSelected[indexPath.row].notificationDetail
        
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
//           func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
    
    
    

   
}
