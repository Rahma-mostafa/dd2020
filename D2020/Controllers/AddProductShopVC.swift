//
//  addProductViewController.swift
//  d2020
//
//  Created by MacBook Pro on 3/9/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class AddProductShopVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var productNameView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productPriceView: UIView!
    @IBOutlet weak var addButton: RoundedButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    var Color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        productView.layer.cornerRadius = 8
        productPriceView.layer.cornerRadius = 8
        uploadButton.layer.cornerRadius = 8
        
    }
    @IBAction func onButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: "Choose Source", preferredStyle: .alert)
        let galleryAction = UIAlertAction(title: "Gallery", style: .destructive){
            _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        lineView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        lineView2.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        addButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        let lbl = UILabel(frame: CGRect(x: 305, y: 8, width: 230, height: 21))
               lbl.textAlignment = .right
               lbl.text = "اسم المنتج"
               lbl.textColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
               lbl.backgroundColor = .clear
               lbl.font = UIFont.systemFont(ofSize: 14)
               //To display multiple lines in label
               lbl.numberOfLines = 0 //If you want to display only 2 lines replace 0(Zero) with 2.
               lbl.lineBreakMode = .byWordWrapping //Word Wrap
               // OR
               lbl.lineBreakMode = .byCharWrapping //Charactor Wrap
               lbl.sizeToFit()//If required
               productView.addSubview(lbl)
        let lbl2 = UILabel(frame: CGRect(x: 301, y: 8 , width: 230, height: 21))
                      lbl2.textAlignment = .right //For center alignment
                      lbl2.text = "السعر بالريال"
                      lbl2.textColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
                      lbl2.backgroundColor = .clear //If required
                      lbl2.font = UIFont.systemFont(ofSize: 14)
                      //To display multiple lines in label
                      lbl2.numberOfLines = 0 //If you want to display only 2 lines replace 0(Zero) with 2.
                      lbl2.lineBreakMode = .byWordWrapping //Word Wrap
                      // OR
                      lbl2.lineBreakMode = .byCharWrapping //Charactor Wrap
                      lbl2.sizeToFit()//If required
                    productPriceView.addSubview(lbl2)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true)
        let userSelectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.image = userSelectedImage
        imageView.image = userSelectedImage
        //uploadButton.backgroundColor = #colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1)
    }
    @IBAction func onAddButtonClick(_ sender: Any) {
    }
}
