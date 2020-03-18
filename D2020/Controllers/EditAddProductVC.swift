//
//  testViewController.swift
//  D2020
//
//  Created by MacBook Pro on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class EditAddProductVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
   
    @IBOutlet weak var confirmationButton: RoundedButton!
    var image: UIImage!
        var imagePicker = UIImagePickerController()
        var slideShow:[SlideShow] = [SlideShow(image:"maksim-zhashkevych-qXfLGt9nh2Y-unsplash"),
        SlideShow(image:"maksim-zhashkevych-qXfLGt9nh2Y-unsplash"),
        SlideShow(image:"maksim-zhashkevych-qXfLGt9nh2Y-unsplash"),
        SlideShow(image:"maksim-zhashkevych-qXfLGt9nh2Y-unsplash")
        ]
        var product:[Products] = [Products(image:"edgar-castrejon-1SPu0KT-Ejg-unsplash", name: "اسم المنتج " ,price:"١٤ ريال "),Products(image:"edgar-castrejon-1SPu0KT-Ejg-unsplash", name: "اسم المنتج " ,price:"١٤ ريال "),Products(image:"edgar-castrejon-1SPu0KT-Ejg-unsplash", name: "اسم المنتج " ,price:"١٤ ريال "),Products(image:"edgar-castrejon-1SPu0KT-Ejg-unsplash", name: "اسم المنتج " ,price:"١٤ ريال "),Products(image:"edgar-castrejon-1SPu0KT-Ejg-unsplash", name: "اسم المنتج " ,price:"١٤ ريال ")]
        
        
        
        
        
        var currentSlideIndex = 0
        var sliderTimer: Timer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            slideShowCollectionView.dataSource = self
            slideShowCollectionView.delegate = self
            pageView.numberOfPages = slideShow.count
            pageView.currentPage = 0
            makeSliderSlidesAutomatically()
            imagePicker.delegate = self
            pictureView.layer.cornerRadius = 40
            imageView.layer.cornerRadius = 40
            productCollectionView.delegate = self
            productCollectionView.dataSource = self
            confirmationButton.layer.cornerRadius = 24
            
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(true)
            sliderTimer?.invalidate()
        }
        
        func makeSliderSlidesAutomatically(){
            sliderTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) {[unowned self] timer in
                if self.currentSlideIndex < self.slideShow.count - 1  {
                    self.pageView.currentPage = self.currentSlideIndex
                    self.currentSlideIndex += 1
                }else{
                    self.currentSlideIndex = 0
                    self.pageView.currentPage = self.currentSlideIndex
                    self.currentSlideIndex = 1

                }
                self.slideShowCollectionView.scrollToItem(at: IndexPath(item: self.currentSlideIndex, section: 0), at: .centeredHorizontally, animated: true)
          }
            sliderTimer?.fire()
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == slideShowCollectionView{
                return slideShow.count
            }else{
                return product.count
            }
            
            
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == slideShowCollectionView{
                if let cell = slideShowCollectionView.dequeueReusableCell(withReuseIdentifier: "slideShowCell", for: indexPath) as? slideShowCollectionViewCell {
                    cell.sliderImageView.image = UIImage(named:slideShow[indexPath.row].image )
                    return cell
                    }
            }else{
                if let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? productsCollectionViewCell {
                    cell.productImageView.image = UIImage(named:product[indexPath.row].image )
                    cell.productNameLabel.text = product[indexPath.item].name
                    cell.productPriceLabel.text = product[indexPath.item].price
                    cell.editButton.tag = indexPath.row
                    cell.editButton.addTarget(self, action: Selector(("onEditButtonPressed")) , for:.touchUpInside )
                    
                    return cell
                  }
            }
            return UICollectionViewCell()
        }
       @objc func onEditButtonPressed(){
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let scene = storyboard.instantiateViewController(withIdentifier: "addProductViewController")
            self.present(scene, animated: true , completion: nil)
        }
        

        
        @IBAction func onAddButtonClick(_ sender: Any) {
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
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               imagePicker.dismiss(animated: true)
               let userSelectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
               self.image = userSelectedImage
               imageView.image = userSelectedImage
               
           }
        

    }
