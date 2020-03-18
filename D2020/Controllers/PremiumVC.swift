//
//  PremiumVC.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct PremiumServices {
    var ServiceImage:String?
}

class PremiumVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource  {
    
    // Mark: - IBOutlet
       
    
    @IBOutlet weak var pageView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var communicate: UIView!
    
    @IBOutlet weak var workTime: UIView!
    
    @IBOutlet weak var info: UIView!
    
    @IBOutlet weak var roundedPic: UIView!
    
    @IBOutlet weak var profileRounded: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    //Variables Services CollectionView
    
    var premiumService :[PremiumServices] = [PremiumServices(ServiceImage: "wifi"),PremiumServices(ServiceImage: "pawprint"),PremiumServices(ServiceImage: "Mask Group 1"),PremiumServices(ServiceImage: "pawprint"),PremiumServices(ServiceImage: "pawprint"),PremiumServices(ServiceImage: "pawprint"),PremiumServices(ServiceImage: "pawprint")]
    
    
    
    
    
    
    //Variables slideShow
    
    var pageViewController:UIPageViewController?
    let arrayPageImage = ["Apple iPhone tricks","Apple iPhone tricks","Apple iPhone tricks"]
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        roundedPic.layer.cornerRadius = 50
        profileRounded.layer.cornerRadius = 50
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(PremiumVC.loadNextController), userInfo: nil, repeats: true)
        setPageViewController()

       
    }
    

          private func setPageViewController(){
              let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC3") as? UIPageViewController
              pageVC?.dataSource
               = self
              
             let firstController = getViewController(atIndex: 0)
            pageVC?.setViewControllers([firstController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            
            self.pageViewController = pageVC
            
            self.addChild(self.pageViewController!)
            self.pageView.addSubview(self.pageViewController!.view)
            self.pageViewController?.didMove(toParent: self)
          }
          
          
    fileprivate func getViewController(atIndex index: Int) -> PremiumContentVC {
              let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC3") as! PremiumContentVC
        
            promoContentVC.ImmageName = arrayPageImage[index]
            promoContentVC.PaageIndex = index
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                  
              //bt3rd l width bta3 l mobile
                  let width = view.frame.width
                  //(11) moheeeeemaaaaa ->na2s 30 34an 3ndi 10 3lymen w 10 3l 4mal w 10 l min soacing fhib2o 30 lly homa m4 mst5dmnhom,y3ni hn5li l width bta3 l collectionView m2som 3la 5lyten bs y3ni hn3rd 5lyten hna bs f msa7a l collectionView kolha
                  let cellWidth = (width - 50) / 4
               let cellHeight = cellWidth * 1.5
                  
              return CGSize(width: cellWidth, height: cellHeight)
              
          }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return premiumService.count
    
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.PremiumServices, for: indexPath) as? PremiumServicesCell
        
        cell?.circledImage.image = UIImage(named: premiumService [indexPath.item].ServiceImage!)
        
        
        
        
        
        return cell!
           }

    
    
    
    @IBAction func showComponents(_ sender: Any) {
        
        if ((sender as AnyObject).selectedSegmentIndex == 0 ) {
                  UIView.animate(withDuration: 0.5, animations: {
                    self.communicate.alpha = 1
                    self.workTime.alpha = 0
                      self.info.alpha = 0
                      
                  }
                  )
              }
        
        else if ((sender as AnyObject).selectedSegmentIndex == 1 ) {
                   UIView.animate(withDuration: 0.5, animations: {
                    self.workTime.alpha = 1
                       self.info.alpha = 0
                       
                       self.communicate.alpha = 0
                       
                      
                   })
               }
        
        
        else  {
                   UIView.animate(withDuration: 0.5, animations: {
                       self.info.alpha = 1
                       self.communicate.alpha = 0
                       
                    self.workTime.alpha = 0
                       
                       
                   })
               }
        
        
    
    

  

    }
}


//extension uipageviewcontrollerdatasource

extension PremiumVC :UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PremiumContentVC
        var index = pageContentVC.PaageIndex
        if index == 0 || index == NSNotFound {
            return getViewController(atIndex: arrayPageImage
                .count - 1)
            
            //0 |1 |2 |0|1|2.......
        }
        index  -= 1
        return getViewController(atIndex: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PremiumContentVC
        var index = pageContentVC.PaageIndex
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
