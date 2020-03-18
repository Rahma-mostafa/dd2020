//
//  ProfileVC.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import MapKit

class ProfileVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
     //Variables -> collectionView
    
    struct CollectionItem {
        var name: String?
        var imageName:String?
       
    }
    //Variables QRCode
    
  
    
    
    var collectionItems:[CollectionItem] = [CollectionItem(name: "٤٠ ريال", imageName: "jeremy-ricketts-6ZnhM-xBpos-unsplash"),CollectionItem(name: "٥٠ ريال", imageName: "jonathan-borba-u7fi6JmYbX8-unsplash"),CollectionItem(name: "١٥٠ ريال", imageName: "chad-montano-MqT0asuoIcU-unsplash"),CollectionItem(name: "٢٠٠ ريال", imageName: "89e383d6895717eb3d5e76fb6f9835f5")]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var roundedview: RoundedShadowView!
    
    @IBOutlet weak var roundedImage: UIImageView!
    //Variables slideShow

   
    
    var pageViewController:UIPageViewController?
    let arrayPageImage = ["maksim-zhashkevych-qXfLGt9nh2Y-unsplash","maksim-zhashkevych-qXfLGt9nh2Y-unsplash","maksim-zhashkevych-qXfLGt9nh2Y-unsplash"]
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
               collectionView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ProfileVC.loadNextController), userInfo: nil, repeats: true)
        setPageViewController()
        
        roundedview.layer.cornerRadius = 50
        roundedImage.layer.cornerRadius = 50
        
        
      
        
        
    }
    
   
    @IBAction func callBtn(_ sender: UIButton) {
        
        guard let numberString = sender.titleLabel?.text, let url = URL(string: "telprompt://\(numberString)")else {
            return
        }
        
        UIApplication.shared.open(url)
        
        
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    @IBAction func getDirectionPressed(_ sender: Any) {
        
        
            let latitude:CLLocationDegrees = 29.979335899999995
            let longitude:CLLocationDegrees = 31.1278879
            
            let regionDistance:CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate:regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan:regionSpan.span)]
            let placeMark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placeMark)
            mapItem.openInMaps(launchOptions: options)
            
        

        
    }
    
    
    
    
    @IBAction func qrCode(_ sender: Any) {
        
         
    }
    
    
    @IBAction func share(_ sender: Any) {
        
        let text = "share This Content With"
        
        let url : NSURL = NSURL(string: "www.google.com")!
        let image = UIImage(named: "egypt")
        let vc = UIActivityViewController(activityItems: [text,url,image!], applicationActivities: [])
        
        if let popOverController = vc.popoverPresentationController{
            popOverController.sourceView = self.view
            popOverController.sourceRect = self.view.bounds
        }
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return collectionItems.count
           }
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProfileCollectionViewCell, for: indexPath) as? ProfileCollectionViewCell
            
            
            cell?.profileCollectionImg.image = UIImage(named: collectionItems[indexPath.item].imageName!)
            
            cell?.profileTitleCell.text = collectionItems[indexPath.item].name
           

            
            
            return cell!
               }
              
           //(10) d lly btt7km f 7gm l cell lyy htt3rdly 7sb 7gm l telephone lly h3rd 3leh
               func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                   
               //bt3rd l width bta3 l mobile
                   let width = view.frame.width
                   //(11) moheeeeemaaaaa ->na2s 30 34an 3ndi 10 3lymen w 10 3l 4mal w 10 l min soacing fhib2o 30 lly homa m4 mst5dmnhom,y3ni hn5li l width bta3 l collectionView m2som 3la 5lyten bs y3ni hn3rd 5lyten hna bs f msa7a l collectionView kolha
                   let cellWidth = (width - 50) / 4
                              let cellHeight = cellWidth * 1.5
                                 
                             return CGSize(width: cellWidth, height: cellHeight)
               
           }
        

    

    
          private func setPageViewController(){
              let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC2") as? UIPageViewController
              pageVC?.dataSource
               = self
              
             let firstController = getViewController(atIndex: 0)
            pageVC?.setViewControllers([firstController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            
            self.pageViewController = pageVC
            
            self.addChild(self.pageViewController!)
            self.pageView.addSubview(self.pageViewController!.view)
            self.pageViewController?.didMove(toParent: self)
          }
          
          
    fileprivate func getViewController(atIndex index: Int) -> ProfileContentVC {
              let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "profileContentVC") as! ProfileContentVC
        
        promoContentVC.ImageName = arrayPageImage[index]
        
        promoContentVC.PageIndex = index
        
        return promoContentVC
        
       
              
          }
        @objc private func loadNextController(){
            currentIndex += 1
            
            if currentIndex == arrayPageImage.count {
                currentIndex = 0
            }
            
            let nextController = getViewController(atIndex: currentIndex)
            
            self.pageViewController?.setViewControllers([nextController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            
            self.pageControl.currentPage = currentIndex
            
        }


    }
    //extension uipageviewcontrollerdatasource

    extension ProfileVC :UIPageViewControllerDataSource {
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let pageContentVC = viewController as! ProfileContentVC
            var index = pageContentVC.PageIndex
            if index == 0 || index == NSNotFound {
                return getViewController(atIndex: arrayPageImage
                    .count - 1)
                
                //0 |1 |2 |0|1|2.......
            }
            index  -= 1
            return getViewController(atIndex: index)
        }
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let pageContentVC = viewController as! ProfileContentVC
            var index = pageContentVC.PageIndex
            if index == NSNotFound {
                return nil
            }
            index += 1
            if index == arrayPageImage.count {
                return getViewController(atIndex: 0)
            }
            return getViewController(atIndex: index)
        }
    }




