//
//  PremiumProductsVC.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct premiumSelected {
    var premiumName:String?
    var premiumImage:String?
    var premiumPrice:String?
}

class PremiumProductsVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource  {
    
    @IBOutlet weak var cl: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        cl.delegate = self
        cl.dataSource = self
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //
    //         selectedPremium = premiumSelected[indexPath.item].premiumName
    //           selectedCategory = items[indexPath.item].imageName
    //
    //        performSegue(withIdentifier: Segues.ToSelectedCategory, sender: self)
    //
    //    }
    
    var selectedPremium :[premiumSelected] = [premiumSelected(premiumName: "قهوة فرنساوي", premiumImage: "jeremy-ricketts-6ZnhM-xBpos-unsplash",premiumPrice: "30 ريال"),premiumSelected(premiumName: "قهوة تركي", premiumImage: "jonathan-borba-u7fi6JmYbX8-unsplash",premiumPrice: "٢٠ ريال"),premiumSelected(premiumName: "فرينش كافيه", premiumImage: "cold brew",premiumPrice: "٥٠ ريال"),premiumSelected(premiumName: "فرينش كافيه", premiumImage: "cold brew",premiumPrice: "٥٠ ريال"),premiumSelected(premiumName: "فرينش كافيه", premiumImage: "cold brew",premiumPrice: "٥٠ ريال")]
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //bt3rd l width bta3 l mobile
        let width = view.frame.width
        //(11) moheeeeemaaaaa ->na2s 30 34an 3ndi 10 3lymen w 10 3l 4mal w 10 l min soacing fhib2o 30 lly homa m4 mst5dmnhom,y3ni hn5li l width bta3 l collectionView m2som 3la 5lyten bs y3ni hn3rd 5lyten hna bs f msa7a l collectionView kolha
        let cellWidth = (width - 50) / 4
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPremium.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.PremiumProductsCell, for: indexPath) as? PremiumProductsCell
        
        cell?.premiumPrice.text =  selectedPremium[indexPath.item].premiumPrice
        
        
        cell?.premiumImage.image = UIImage(named: selectedPremium[indexPath.item].premiumImage!)
        
        cell?.premiumTitle.text = selectedPremium[indexPath.item].premiumName
        
        
        return cell!
    }
    
}


