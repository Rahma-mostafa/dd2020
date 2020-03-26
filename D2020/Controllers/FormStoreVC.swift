//
//  FormStoreVC.swift
//  D2020
//
//  Created by Macbook on 3/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class FormStoreVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var img: UIImageView!
    
    
    @IBOutlet weak var btnOutlet: UIButton!
    
    
    //Variables
       
       var imagePicker = UIImagePickerController()
       var image:UIImage!
    
    //Variables -> picker
    
    var alertController:UIAlertController?
    
    var pickerController:UIImagePickerController?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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
    
    
    func dismiss(){
        dismiss(animated: true, completion: nil)
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
        self.img?.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func btnChoose(_ sender: Any) {
        
        
        
        
        
               alertController = UIAlertController(title: "Take Image", message: "Choose Image Source", preferredStyle: .actionSheet)
                      let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                          print("you choose camera")
                          self.openCamera()
                      }
                      let photoAction = UIAlertAction(title: "Your Photos", style: .default) { (action) in
                      print("you choose Photo")
                      self.openPhoto()
        }
                        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
                            self.dismiss()
                        }
                      
                      alertController?.addAction(cameraAction)
                      alertController?.addAction(photoAction)
        
        alertController?.addAction(cancel)
        
                      alertController?.view.tintColor = UIColor.magenta
                     
        
        
        self.present(alertController!, animated: true){
                          print("presented")
                      }
               
               
               
               
           
           
        
        
        
        
    }
    
}
