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
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
    }
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLbl.text = "notifications.lan".localized
    }
}
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.NotificationsCell , for: indexPath) as! NotificationsCell
        return cell
    }
}

