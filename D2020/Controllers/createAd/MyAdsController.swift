//
//  AddShopVC.swift
//  D2020
//
//  Created by Macbook on 3/5/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire



class MyAdsController: BaseController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNoShop: UIView!
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var storeDescLbl: UILabel!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var notFoundLbl: UILabel!
    @IBOutlet weak var cloudView: UIView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var imageStyle: UIImageView!
    
    var contentIndex : Int?
    var ads: [MyStores.Datum] = []
    var section: Int?
    var style: Style = .green
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setup()
        localize()
        fetchAds()
        
        
    }
    func setupStyle() {
        switch style {
        case .red:
            self.navigationController?.navigationBar.barTintColor = .appRed
            self.view.backgroundColor = .appRed
            self.cloud1.image = UIImage(named: "cloudRed")
            self.cloud2.image = UIImage(named: "cloudRed1")
            self.circle.image = UIImage(named: "circleRed")
            self.imageStyle.image = UIImage(named: "teamRed")
        default:
            break
        }
        
    }
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func localize() {
        titleBar.title = "my.ads.lan".localized
        storeLbl.text = "products.lan".localized
        storeDescLbl.text = "my.products.desc.lan".localized
        notFoundLbl.text = "not.found.products.lan".localized
    }
    func handleView() {
        if ads.count > 0 {
            viewNoShop.isHidden = true
            tableViewTop.constant = 0
        }
        let model = MyStores.Datum()
        self.ads.append(model)
        self.tableView.reloadData()
    }
    func fetchAds() {
        startLoading()
        ApiManager.instance.connection(.myAds, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(MyStores.self, from: response ?? Data())
            self?.ads.append(contentsOf: data?.data ?? [])
            self?.handleView()
        }
    }
    
    func addAds() {
        let vc = controller(AddAdDetailController.self, storyboard: .createAd)
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
extension MyAdsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.ShopsAddedCell , for: indexPath) as! ShopsAddedCell
        cell.setStyle = style
        if indexPath.row == self.ads.count-1 {
            cell.setupDefault()
            cell.plusBtn.UIViewAction { [weak self] in
                self?.addAds()
            }
        } else {
            cell.model = ads[indexPath.row]
            cell.trash.UIViewAction { [weak self] in
                self?.removeAds(path: indexPath.row)
            }
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.ads.count-1 {
            self.addAds()
        } else {
            let vc = pushViewController(MyAdsDetailController.self, storyboard: .ads)
            vc.style = style
            vc.adsID = self.ads[indexPath.row].id
            vc.section = self.section
            push(vc)
        }
    }
    
}

extension MyAdsController {
    func removeAds(path: Int) {
        guard let adsID = self.ads[path].id else { return }
        self.ads.remove(at: path)
        self.ads.removeLast()
        self.handleView()
        let method = api(.deleteAd, [adsID])
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            
        }
    }
}
