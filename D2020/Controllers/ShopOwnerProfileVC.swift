//
//  ShopOwnerProfileVC.swift
//  D2020
//
//  Created by Macbook on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct ShopOwnerItems {
    
    var itemName:String?
    var itemImag:String?
    var itemCost:String?
}

class ShopOwnerProfileVC: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var roundedImage: UIImageView!
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables :-
    var shopOwnerItem:[ShopOwnerItems] = [ShopOwnerItems(itemName: "قهوة فرنساوي", itemImag: "cold brew",itemCost:  "٣٠ ريال"),ShopOwnerItems(itemName: "قهوة فرنساوي", itemImag: "cold brew",itemCost:  "٣٠ ريال"),ShopOwnerItems(itemName: "قهوة فرنساوي", itemImag: "cold brew",itemCost:  "٣٠ ريال"),ShopOwnerItems(itemName: "قهوة فرنساوي", itemImag: "cold brew",itemCost:  "٣٠ ريال"),ShopOwnerItems(itemName: "قهوة فرنساوي", itemImag: "cold brew",itemCost:  "٣٠ ريال")]
    
//Variables SlideShow
    //Variables slideShow
    
    var pageViewController:UIPageViewController?
    let arrayPageImage = ["louis-hansel-shotsoflouis-Si5lP0g-sR8-unsplash","jeremy-ricketts-6ZnhM-xBpos-unsplash","WELCOME2"]
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ShopOwnerProfileVC.loadNextController), userInfo: nil, repeats: true)
             setPageViewController()
        
        roundedView.layer.cornerRadius = 43
        roundedImage.layer.cornerRadius = 43
      
    }
    
     private func setPageViewController(){
              let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVCC") as? UIPageViewController
              pageVC?.dataSource
                = self as? UIPageViewControllerDataSource
              
             let firstController = getViewController(atIndex: 0)
            pageVC?.setViewControllers([firstController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            
            self.pageViewController = pageVC
            
            self.addChild(self.pageViewController!)
            self.pageView.addSubview(self.pageViewController!.view)
            self.pageViewController?.didMove(toParent: self)
          }
          
          
    fileprivate func getViewController(atIndex index: Int) -> PromoContentVCC {
              let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVCC") as! PromoContentVCC
        
            promoContentVC.ImmmageName = arrayPageImage[index]
            promoContentVC.PaaageIndex = index
        
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
        
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopOwnerItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ShopOwnerProducts, for: indexPath) as! ShopOwnerProducts
        
        cell.productOwner.image = UIImage(named: shopOwnerItem[indexPath.item].itemImag!)
        
        cell.productOwnerTitle.text = shopOwnerItem[indexPath.item].itemName
        
        cell.productOwnerPrice.text = shopOwnerItem[indexPath.item].itemCost
        
        
        
        return cell
    }
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

               //bt3rd l width bta3 l mobile
                   let width = view.frame.width
                   //(11) moheeeeemaaaaa ->na2s 30 34an 3ndi 10 3lymen w 10 3l 4mal w 10 l min soacing fhib2o 30 lly homa m4 mst5dmnhom,y3ni hn5li l width bta3 l collectionView m2som 3la 5lyten bs y3ni hn3rd 5lyten hna bs f msa7a l collectionView kolha
                   let cellWidth = (width - 250)
                let cellHeight =   cellWidth * 1

                return CGSize(width: cellWidth, height: cellHeight)

           }
        
        
//           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            selectedCategory = items[indexPath.item].name
//            selectedCategory = items[indexPath.item].description
    //        selectedCategory = UIImage(named: items[indexPath.item].imageName!)
            
//                    performSegue(withIdentifier: Segues.ToProducts, sender: self)
//
//            }

   

}
