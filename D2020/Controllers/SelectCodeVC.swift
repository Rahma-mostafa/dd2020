//
//  SelectCodeVC.swift
//  D2020
//
//  Created by Macbook on 3/27/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit


struct CodeSelected {
    var codeTitle:String?
    var imgCode:String?
}

class SelectCodeVC: BaseController,UITableViewDelegate,UITableViewDataSource {
   
    

    var selectCode : [CodeSelected] = [CodeSelected(codeTitle:"+02",imgCode:"egypt")]
    
    
     @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectCode.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CodeCell, for:indexPath) as? CodeCell
        
        cell?.codeTitle.text = selectCode[indexPath.row].codeTitle
        
        cell?.imgCode.image = UIImage(named: selectCode[indexPath.row].imgCode!)
        
        return cell!
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    
    
    
    

   
    
    
    
    
    
    

}
