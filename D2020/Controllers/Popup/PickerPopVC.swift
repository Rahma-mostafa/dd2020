//
//  changeCityViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PickerPopVC: BaseController {
   
    
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    

    var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var text: String?
    var source: [Any] = []
    var titleClosure: PickerTitleHandler?
    var didSelectClosure: PickerDidSelectPath?
    var didSelectItemClosure: PickerDidSelectItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLbl.text = self.text
        cityTableView.delegate = self
        cityTableView.dataSource = self
        self.view.UIViewAction {
            self.dismiss(animated: true, completion: nil)
        }
        
    }

}

extension PickerPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  cityTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? ChangeCityTableViewCell {
            cell.cityLabel.text = titleClosure?(indexPath.row)
            cell.closeButton.tag = indexPath.row
            cell.onCloseButtonTapped = { [weak self] in
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
                self?.dismiss(animated: true, completion: {
                    self?.didSelectClosure?(indexPath.row)
                    self?.didSelectItemClosure?(self?.source[indexPath.row] ?? "")
                })
            }
            if indexPath.row % 2 == 0 {
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
            }
            return cell
        }
        return UITableViewCell()
    }
}
