//
//  NotificationsVC.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class NotificationsVC: BaseController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newestLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var notifications: [NotificationModel.Datum] = []
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotifications()
    }
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLbl.text = "notifications.lan".localized
        newestLbl.text = "newest.lan".localized
    }
    func fetchNotifications() {
        ApiManager.instance.connection(.notifications, type: .get) { (response) in
            let data = try? JSONDecoder().decode(NotificationModel.self, from: response ?? Data())
            self.notifications.removeAll()
            self.notifications.append(contentsOf: data?.data ?? [])
            self.tableView.reloadData()
        }
    }
}
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.NotificationsCell , for: indexPath) as! NotificationsCell
        cell.model = notifications[indexPath.row]
        return cell
    }
}

