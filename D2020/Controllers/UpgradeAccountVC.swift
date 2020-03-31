//
//  RegisterAsVC.swift
//  D2020
//
//  Created by Macbook on 3/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

protocol UpgradeAccountDelegate: class {
    func didUpgrade()
}
class UpgradeAccountVC: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var registerAsLbl: UILabel!
    @IBOutlet weak var confirmBtn: RoundedButton!
    
    var sections: [Section.Data] = []
    var selectedSection: Int?
    weak var delegate: UpgradeAccountDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        handlers()
    }
    func setup() {
        confirmBtn.setTitle("confirm.lan".localized, for: .normal)
        self.title = "upgrade.account.only.lan".localized
        registerAsLbl.text = "select.category.lan".localized
        tableView.delegate = self
        tableView.dataSource = self
        fetchSection()
    }
    func fetchSection() {
        startLoading()
        ApiManager.instance.connection(.upgradeSections, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Section.self, from: response ?? Data())
            self?.sections.append(contentsOf: data?.data ?? [])
            self?.tableView.reloadData()
        }
    }
    func handlers() {
        confirmBtn.UIViewAction {
            self.upgradeAccount()
        }
    }
    func upgradeAccount() {
        guard let selectedSection = selectedSection else { return }
        startLoading()
        ApiManager.instance.paramaters["section_id"] = sections[selectedSection].id
        ApiManager.instance.connection(.upgradeAccount, type: .post) { [weak self] (response) in
            self?.stopLoading()
            self?.delegate?.didUpgrade()
            self?.navigationController?.popViewController(animated: true)
        }
    }
}


extension UpgradeAccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.RegisterTableView , for: indexPath) as! RegisterTableViewCell
        if selectedSection == indexPath.row {
            cell.containerView.backgroundColor = .appOrange
            cell.checkImage.isHidden = false
            cell.titleRegister.textColor = .white
        } else {
            cell.containerView.backgroundColor = .white
            cell.checkImage.isHidden = true
            cell.titleRegister.textColor = .black
        }
        cell.imgRegister.setImage(url: sections[indexPath.row].image)
        cell.titleRegister.text = sections[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == selectedSection {
            selectedSection = nil
            confirmBtn.backgroundColor = .textColor
        } else {
            selectedSection = indexPath.row
            confirmBtn.backgroundColor = .appOrange
        }
        
        tableView.reloadData()
    }
    
}
