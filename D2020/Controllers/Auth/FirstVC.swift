//
//  FirstVC.swift
//  D2020
//
//  Created by Macbook on 3/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class FirstVC: BaseController {

    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var loginBtn: RoundedButton!
    
    var sliders: [Slider.Data] = []
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        fetchSliders()
        
    }

    func setup() {
        UserDefaults.standard.set(true, forKey: "ON_BOARDING")
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        loginBtn.setTitle("login.lan".localized, for: .normal)
        loginBtn.UIViewAction {
            let vc = self.controller(LoginVC.self, storyboard: .auth)
            self.push(vc)
        }
        
    }
    func fetchSliders() {
        startLoading()
        ApiManager.instance.paramaters["type"] = 1
        ApiManager.instance.connection(.getSlider, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Slider.self, from: response ?? Data())
            self?.sliders.removeAll()
            self?.sliders.append(contentsOf: data?.data ?? [])
            self?.sliderCollection.reloadData()
        }
    }
}
extension FirstVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = sliders.count
        return sliders.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: OnboardingCell.self, indexPath, register: false)
        cell.image.setImage(url: sliders[indexPath.row].file)
        cell.titleBoarding.text = sliders[indexPath.row].title
        cell.descBoarding.text = sliders[indexPath.row].desc
        return cell
    }
    
    
}
