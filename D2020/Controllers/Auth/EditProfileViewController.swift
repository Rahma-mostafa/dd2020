//
//  editProfileViewController.swift
//  d2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseController {

    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var upgradeBtn: RoundedButton!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var editMobileBtn: UIButton!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var editEmailBtn: UIButton!
    @IBOutlet weak var bithdateTxf: UITextField!
    @IBOutlet weak var editBirthdateBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var cityTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var changePasswordBtn: RoundedButton!
    @IBOutlet weak var newPasswordView: RoundedShadowView!
    @IBOutlet weak var newPasswordTxf: UITextField!
    
    var picker: GalleryPickerHelper?
    var imageURL: URL?
    var cities: [CityModel.CityData] = []
    var selectedCity: Int?
    let datePicker = UIDatePicker()
    var gender: Int = 1
    var enableEdit: Bool = false
    var enablePasswordEdit: Bool = false
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
        handlers()
        fetchCities()
        showDatePicker()
    }
    func setup() {
        picker = .init()
        let user = UserRoot.fetch()?.user
        setupUnEdit()
        profileLbl.text = "profile.lan".localized
        upgradeBtn.setTitle("upgrade.account.lan".localized, for: .normal)
        userImage.setImage(url: user?.image)
        usernameLbl.text = user?.name
        typeLbl.text = ""
        nameTxf.text = user?.name
        mobileTxf.text = user?.phone
        emailTxf.text = user?.email
        bithdateTxf.text = user?.birth_date
        cityTxf.text = user?.City?.name
        changePasswordBtn.setTitle("change.lan".localized, for: .normal)
        
        if user?.gender == 2 {
            femaleBtn.borderWidth = 1
            femaleBtn.borderColor = .black
            maleBtn.borderWidth = 0
        } else {
            maleBtn.borderWidth = 1
            maleBtn.borderColor = .black
            femaleBtn.borderWidth = 0
        }
    }
    func setupUnEdit() {
         enableEdit = false
        editBtn.setTitle("edit.lan".localized, for: .normal)
        editBtn.backgroundColor = .clear
        editBtn.setTitleColor(.white, for: .normal)
        editBtn.borderColor = .white
        editBtn.borderWidth = 1
        
        nameTxf.isUserInteractionEnabled = false
        emailTxf.isUserInteractionEnabled = false
        mobileTxf.isUserInteractionEnabled = false
        bithdateTxf.isUserInteractionEnabled = false
        userImage.isUserInteractionEnabled = false

    }
    func setupEdit() {
        enableEdit = true
        editBtn.setTitle("save.lan".localized, for: .normal)
        editBtn.backgroundColor = .white
        editBtn.setTitleColor(.appOrange, for: .normal)
        editBtn.borderColor = .white
        editBtn.borderWidth = 0
        
        nameTxf.isUserInteractionEnabled = true
        emailTxf.isUserInteractionEnabled = true
        mobileTxf.isUserInteractionEnabled = true
        bithdateTxf.isUserInteractionEnabled = true
        userImage.isUserInteractionEnabled = true
    }
    func setupPasswordChangeBtn() {
        if enablePasswordEdit {
            self.changePasswordBtn.setTitle("save.lan".localized, for: .normal)
            self.changePasswordBtn.setTitleColor(.appOrange, for: .normal)
            self.changePasswordBtn.backgroundColor = .white
            self.newPasswordView.isHidden = false
            passwordTxf.isUserInteractionEnabled = true
            newPasswordTxf.isUserInteractionEnabled = true
        } else {
            self.changePasswordBtn.setTitle("change.lan".localized, for: .normal)
            self.changePasswordBtn.setTitleColor(.white, for: .normal)
            self.changePasswordBtn.backgroundColor = .appOrange
            self.newPasswordView.isHidden = true
            passwordTxf.isUserInteractionEnabled = false
            newPasswordTxf.isUserInteractionEnabled = false
            passwordTxf.text = nil
            newPasswordTxf.text = nil
        }
    }
    func handlers() {
        editBtn.UIViewAction {
            if self.enableEdit {
                self.updateProfile()
            } else {
                self.setupEdit()
            }
        }
        userImage.UIViewAction {
            self.picker?.onPickImage = { image in
                self.userImage.image = image
            }
            self.picker?.onPickImageURL =  { url in
                self.imageURL = url
            }
            self.picker?.pick(in: self, type: .picture)
        }
        maleBtn.UIViewAction {
            self.maleBtn.borderWidth = 1
             self.maleBtn.borderColor = .black
             self.femaleBtn.borderWidth = 0
            self.gender = 1
        }
        femaleBtn.UIViewAction {
            self.femaleBtn.borderWidth = 1
            self.femaleBtn.borderColor = .black
            self.maleBtn.borderWidth = 0
            self.gender = 2
        }
        changePasswordBtn.UIViewAction {
            if self.enablePasswordEdit {
                self.enablePasswordEdit = false
                self.updatePassword()
            } else {
                self.enablePasswordEdit = true
                self.setupPasswordChangeBtn()
            }
        }
        upgradeBtn.UIViewAction {
            let vc = self.controller(UpgradeAccountVC.self, storyboard: .auth)
            vc.delegate = self
            self.push(vc)
        }
    }
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done.lan".localized, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "cancel.lan".localized, style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        bithdateTxf.inputAccessoryView = toolbar
        bithdateTxf.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        bithdateTxf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }


    func fetchCities() {
        startLoading()
        let method = api(.SubCountry, [CountryViewController.deviceCountry?.id ?? 0])
        ApiManager.instance.connection(method, type: .get) { (response) in
            self.stopLoading()
            let data = try? JSONDecoder().decode(CityModel.self, from: response ?? Data())
            self.cities.append(contentsOf: data?.data ?? [])
        }
    }
    @IBAction func cityPick(_ sender: Any) {
        let picker = self.controller(PickerPopVC.self, storyboard: .pop)
        picker.text = Localizations.selectCity.localized
        picker.source = cities
        picker.titleClosure = { row in
            self.cities[row].name ?? ""
        }
        picker.didSelectClosure = { row in
            self.selectedCity = row
            self.cityTxf.text = self.cities[row].name
        }
        self.pushPop(vcr: picker)
    }
}

extension EditProfileViewController: DownloaderDelegate {
    func updatePassword() {
        startLoading()
        let paramters: [String: Any] = [
            "oldPassword": passwordTxf.text ?? "",
            "newPassword": newPasswordTxf.text ?? ""
        ]
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connection(.editPassword, type: .post) { (response) in
            self.stopLoading()
            let _ = try? JSONDecoder().decode(BaseModel.self, from: response ?? Data())
            self.setupPasswordChangeBtn()
        }
    }
    func updateProfile() {
        guard let imageURL = imageURL else { return }
        let paramters: [String: Any] = [
            "phone": mobileTxf.text ?? "",
            "email": emailTxf.text ?? "",
            "name": nameTxf.text ?? "",
            "city_id": "\(cities[selectedCity ?? 0].id ?? 0)",
            "gender": gender,
            "birth_date": bithdateTxf.text ?? ""
        ]
        
        ApiManager.instance.downloaderDelegate = self
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.uploadFile(EndPoint.update.rawValue, type: .post, file: ["image": imageURL]) { (response) in
            let data = try? JSONDecoder().decode(UserData.self, from: response ?? Data())
            UserRoot.setData(data: data?.data)
            self.setupUnEdit()
        }
    }
}

extension EditProfileViewController: UpgradeAccountDelegate {
    func didUpgrade() {
        self.upgradeBtn.isHidden = true
    }
}
