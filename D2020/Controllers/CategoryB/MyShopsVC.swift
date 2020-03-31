//
//  AddShopVC.swift
//  D2020
//
//  Created by Macbook on 3/5/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire



class MyShopsVC: BaseController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNoShop: UIView!
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var storeDescLbl: UILabel!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var notFoundLbl: UILabel!
    
    var contentIndex : Int?
    var shopAdded: [MyStores.Datum] = []
    var section: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        localize()
        fetchStores()
        
        
    }
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func localize() {
        storeLbl.text = "stores.lan".localized
        storeDescLbl.text = "my.stores.desc.lan".localized
        notFoundLbl.text = "not.found.stores.lan".localized
    }
    func handleView() {
        if shopAdded.count > 0 {
            viewNoShop.isHidden = true
            tableViewTop.constant = 0
        }
        let model = MyStores.Datum()
        self.shopAdded.append(model)
        self.tableView.reloadData()
    }
    func fetchStores() {
        startLoading()
        ApiManager.instance.connection(.stores, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(MyStores.self, from: response ?? Data())
            self?.shopAdded.append(contentsOf: data?.data ?? [])
            self?.handleView()
        }
    }
    
    func addStore() {
        let vc = controller(AddShopDetailVC.self, storyboard: .createStore)
        vc.section = section
        push(vc)
    }
    override func backBtn(_ sender: Any) {
        self.navigationController?.viewControllers.forEach({ (vc) in
            if let poped = vc as? CategoryVC {
                self.navigationController?.popToViewController(poped, animated: true)
            }
        })
    }
}
extension MyShopsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopAdded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.ShopsAddedCell , for: indexPath) as! ShopsAddedCell
        cell.setStyle = .orange
        if indexPath.row == self.shopAdded.count-1 {
            cell.setupDefault()
            cell.plusBtn.UIViewAction { [weak self] in
                self?.addStore()
            }
        } else {
            cell.model = shopAdded[indexPath.row]
            cell.trash.UIViewAction { [weak self] in
                self?.removeStore(path: indexPath.row)
            }
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.shopAdded.count-1 {
            self.addStore()
        } else {
            if self.shopAdded[indexPath.row].type == 1 {
                let vc = controller(MyStorePremuimController.self, storyboard: .store)
                vc.storeID = self.shopAdded[indexPath.row].id
                vc.section = self.section
                push(vc)
            } else {
                let vc = controller(MyStoreDetailController.self, storyboard: .store)
                vc.storeID = self.shopAdded[indexPath.row].id
                vc.section = self.section
                push(vc)
            }
        }
    }
    
}

extension MyShopsVC {
    func removeStore(path: Int) {
        guard let storeID = self.shopAdded[path].id else { return }
        self.shopAdded.remove(at: path)
        self.shopAdded.removeLast()
        self.handleView()
        let method = api(.deleteStore, [storeID])
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            
        }
    }
}
