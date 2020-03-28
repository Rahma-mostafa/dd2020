//
//  PremiumWorkTimeVC.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct premiumTime {
    var day: String?
 
}

class PremiumWorkTimeVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    //Variables CollectionView
    
    var premiumDays:[premiumTime] = [premiumTime(day: "السبت"),premiumTime(day: "الاحد"),premiumTime(day: "الاثنين"),premiumTime(day: "الثلاثاء")
    ,premiumTime(day: "الاربعاء"),premiumTime(day: "الخميس"),premiumTime(day: "الجمعة")]

    @IBOutlet weak var cl: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        cl.delegate = self
        cl.dataSource = self
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
            return premiumDays.count
        
           }
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.PremiumWorkTime, for: indexPath) as? PremiumWorkTimeCell
            
            cell?.weekDays.text =  premiumDays[indexPath.item].day
            
            
            
            
            return cell!
               }

    }

    
    
    

    

