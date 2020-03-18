//
//  AddShopDetailsVC.swift
//  D2020
//
//  Created by Macbook on 3/9/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class AddShopDetailVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
//
//    @IBOutlet weak var selectedImageContainer: UIView!
//    @IBOutlet weak var selectedImageView: UIImageView!
//
//    @IBOutlet weak var selectImageButton: UIButton!
    
    
    //picker
           
    
  
    
    

    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnChooseImageSource: UIButton!
    
    
    @IBOutlet weak var roundedView: UIView!
    
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shopTypeTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cityHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var catagoryNameTextField: UITextField!
    
    @IBOutlet weak var shopTypeTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    //Variables
    
    var imagePicker = UIImagePickerController()
    var image:UIImage!
    
    
    //Variables -> picker
       
       var alertController:UIAlertController?
       
       var pickerController:UIImagePickerController?
        

    override func viewDidLoad() {
        super.viewDidLoad()
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
        
//        roundedProfilePic
        btnChooseImageSource?.layer.cornerRadius = 35
        imageView?.layer.cornerRadius = 45
        roundedView.layer.cornerRadius = 45
         
}
    
   
    
   
    
//
//
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (button) in
//            self.imagePicker.sourceType = .photoLibrary
//        }))
//
//        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
//        self.imagePicker.sourceType = .camera
//        }))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        present(alert, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        imagePicker.dismiss(animated: true, completion: nil)
//        let userSelectionImage = info[UIImagePickerController.InfoKey.originalImage]as! UIImage
//
//        self.image = userSelectionImage
//        selectedImageView.image = userSelectionImage
//
//
//
//    }
    
    func openCamera(){
           pickerController = UIImagePickerController()
           if (UIImagePickerController.isSourceTypeAvailable(.camera) == false) {
               return
           }
           pickerController?.delegate = self
           pickerController?.allowsEditing = true
           pickerController?.sourceType = .camera
           self.present(pickerController!, animated: true){
               print("presented camera")
           }
       }
       func openPhoto(){
           pickerController = UIImagePickerController()
           pickerController?.delegate = self
                  pickerController?.allowsEditing = true
                  pickerController?.sourceType = .photoLibrary
                  self.present(pickerController!, animated: true,completion: nil)
                     
           
       }
       //navigationcontrollerdelegate
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let chosenImage:UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
           self.imageView?.image = chosenImage
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
        
        
  
    
    
    @IBAction func onChooseButtonTapped(_ sender: Any) {
        showTable()

    }
    
    @IBAction func onshopTypeButtonTapped(_ sender: Any) {
        showTypeTable()

    }
    
    
    @IBAction func onCityButtonTapped(_ sender: Any) {
        showCityTable()
    }
    
    private func showTable(){
        tableHeightConstraint.constant = self.view.frame.height + 20
//        shopTypeTableHeightConstraint.constant = self.view.frame.height + 20
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    func hideTable(){
        tableHeightConstraint.constant = 0
//        shopTypeTableHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
      private func showTypeTable(){
        shopTypeTableHeightConstraint.constant = self.view.frame.height + 20
            UIView.animate(withDuration: 0.5) {[unowned self] in
                self.view.layoutIfNeeded()
            }
        }
        func hideTypeTable(){
          shopTypeTableHeightConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {[unowned self] in
                self.view.layoutIfNeeded()
            }
        }
    private func showCityTable(){
        cityHeightConstraint.constant = self.view.frame.height + 20
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    func hideCityTable(){
        cityHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
        
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "CategoryTableSegue"{
                let categoryTableViewController = segue.destination as! catagoryTableViewController
                categoryTableViewController.shouldHideTable = { [unowned self] (restaurantName) in
                    self.hideTable()
                    //Set Restaurant Name Here
                    
                   self.catagoryNameTextField.text = restaurantName
                }
            }else if segue.identifier == "ShopTypeTableSegue"{
                let shopTypeViewController = segue.destination as! shopTypeViewController
                shopTypeViewController.shouldHideTypeTable = { [unowned self] (restaurantName) in
                        self.hideTypeTable()
                        //Set Restaurant Name Here
                        
                       self.shopTypeTextField.text = restaurantName
                        
                }
            }else if segue.identifier == "CityTableSegue" {
                let cityViewController = segue.destination as! cityViewController
                cityViewController.shouldHideTable = {
                    [unowned self] (restaurantName) in
                    self.hideCityTable()
                    self.cityTextField.text = restaurantName
                }
                
        }
        }
    
    
    
    @IBAction func btnChooseImageSource(_ sender: UIButton) {
        
        alertController = UIAlertController(title: "Take Image", message: "Choose Image Source", preferredStyle: .actionSheet)
               let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                   print("you choose camera")
                   self.openCamera()
               }
               let photoAction = UIAlertAction(title: "Your Photos", style: .default) { (action) in
               print("you choose Photo")
               self.openPhoto()
               }
               alertController?.addAction(cameraAction)
               alertController?.addAction(photoAction)
               alertController?.view.tintColor = UIColor.magenta
               self.present(alertController!, animated: true){
                   print("presented")
               }
        
        
        
        
    }
    
    
}

