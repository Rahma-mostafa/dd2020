//
//  optionViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class optionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var optionTableView: UITableView!
    var options:[Option] = [Option(name:"الاقرب"),Option(name:"اماكن مميزه"),Option(name: "الاعلي تقيما")]
    
    
    var shouldHideTable : ((String)->())!
     var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        optionTableView.delegate = self
        optionTableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = optionTableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as? optionTableViewCell{
            cell.optionLabel.text = options[indexPath.item].name
            cell.closeButton.tag = indexPath.row
            cell.onCloseButtonTapped = { [unowned self] in
                self.hideTable(rowIndex: indexPath.row)
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
                }
                if indexPath.row % 2 == 0 {
                cell.closeButton.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
            }
            return cell
        }
        return UITableViewCell()
       }
    func hideTable(rowIndex: Int){
        shouldHideTable(self.options[rowIndex].name)
    }
       


}
