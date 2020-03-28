//
//  MenuVC.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 4/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//#import "SWRevealViewController.h"

import UIKit


class MenuVC: BaseController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var menuCollection: UITableView!
    @IBOutlet weak var uesrType: UILabel!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var storesBtn: UIButton!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var rentBtn: UIButton!
    @IBOutlet weak var rentImage: UIImageView!
    @IBOutlet weak var delegateBtn: UIButton!
    @IBOutlet weak var delegateImage: UIImageView!
    @IBOutlet weak var familyBtn: UIButton!
    @IBOutlet weak var familyImage: UIImageView!
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var viewContainSection: UIView!
    @IBOutlet weak var containSectionHeight: NSLayoutConstraint!
    
    static var currentPage: String = "HomeNav"
    //static var currentIndex: MenuEnum? = .home

    static func resetMenu() {
        MenuVC.currentPage = "HomeNav"
    }
    var sections: [Section.Data] = []
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        if menuCollection != nil {
            //menuCollection.delegate = self
            //menuCollection.dataSource = self
        }
        userName.text = "\(UserRoot.fetch()?.user?.name ?? "")"
        uesrType.text = ""
        userImage.setImage(url: UserRoot.fetch()?.user?.image)
        // Do any additional setup after loading the view.\
        setLocalize()
        setupMenu()
        fetchSection()
    }
    func setLocalize() {
        countryImage.setImage(url: CountryViewController.deviceCountry?.file)
        profileBtn.setTitle(Localizations.profile.localized, for: .normal)
        storesBtn.setTitle(Localizations.stores.localized, for: .normal)
        rentBtn.setTitle(Localizations.rent.localized, for: .normal)
        delegateBtn.setTitle(Localizations.delegates.localized, for: .normal)
        familyBtn.setTitle(Localizations.family.localized, for: .normal)
        aboutBtn.setTitle(Localizations.aboutApp.localized, for: .normal)
        supportBtn.setTitle(Localizations.support.localized, for: .normal)
        shareBtn.setTitle(Localizations.share.localized, for: .normal)
        logoutBtn.setTitle(Localizations.logout.localized, for: .normal)
        langBtn.setTitle("\(Localizations.lang.localized): \(Constants.localeFormatted)", for: .normal)
        countryBtn.setTitle("\(Localizations.country.localized): \(CountryViewController.deviceCountry?.name ?? "")", for: .normal)
    }
    func fetchSection() {
        let method = api(.getSections, [CountryViewController.deviceCountry?.id ?? 0])
        startLoading()
        ApiManager.instance.headers["Country_id"] = String(CountryViewController.deviceCountry?.id ?? 0)
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Section.self, from: response ?? Data())
            self?.sections.removeAll()
            self?.sections.append(contentsOf: data?.data ?? [])
            self?.setupMenu()
        }
    }
    func setupMenu() {
        storesBtn.isHidden = true
        familyBtn.isHidden = true
        delegateBtn.isHidden = true
        rentBtn.isHidden = true
        containSectionHeight.constant = 60
        sections.forEach { (item) in
            if item.style == 1 {
                rentBtn.isHidden = false
                rentImage.isHidden = false
                containSectionHeight.constant += 60
            } else if item.style == 2 {
                storesBtn.isHidden = false
                storeImage.isHidden = false
                containSectionHeight.constant += 60
            } else if item.style == 3 {
                delegateBtn.isHidden = false
                delegateImage.isHidden = false
                containSectionHeight.constant += 60
            } else if item.style == 4 {
                familyBtn.isHidden = false
                familyImage.isHidden = false
                containSectionHeight.constant += 60
            }
        }
    }
    @IBAction func shareApp(_ sender: Any) {
        D2020.shareApp(items: [])
    }
    @IBAction func support(_ sender: Any) {
        
    }
    @IBAction func aboutApp(_ sender: Any) {
        
    }
    @IBAction func family(_ sender: Any) {
        
    }
    @IBAction func delegates(_ sender: Any) {
        
    }
    @IBAction func rent(_ sender: Any) {
        
    }
    @IBAction func stores(_ sender: Any) {
        sections.forEach { (item) in
            if item.style == 2 {
                let vc = controller(CategoryVC.self, storyboard: .category)
                vc.section = item.id
                vc.sectionName = item.name
                push(vc)
            }
        }
        
    }
    @IBAction func profile(_ sender: Any) {
        if let _ = UserRoot.token() {
            let vc = controller(EditProfileViewController.self, storyboard: .auth)
            push(vc)
        } else {
            UserRoot.loginAlert() {
                let vc = self.controller(LoginVC.self, storyboard: .auth)
                self.push(vc)
            }
        }
     
    }
    @IBAction func logout(_ sender: Any) {
        UserRoot.save(response: Data())
        UserRoot.setData(data: nil)
        let vc = controller(LoginVC.self, storyboard: .auth)
        push(vc)
    }
}

