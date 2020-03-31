//
//  HomeVC.swift
//  D2020
//
//  Created by Macbook on 2/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit


class HomeVC: BaseController {
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewB: UITableView!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    
    
    var pageViewController:UIPageViewController?
    var currentIndex = 0
    var selectedCategory : String?
    var sections: [Section.Data] = []
    var sliders: [Slider.Data] = []
    static var sections: [Section.Data] = []
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
        fetchSection()
        fetchSliders()
    }
    func setup() {
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableViewB.delegate = self
        tableViewB.dataSource = self
    }
    func fetchSection() {
        let method = api(.getSections, [CountryViewController.deviceCountry?.id ?? 0])
        startLoading()
        ApiManager.instance.headers["Country_id"] = String(CountryViewController.deviceCountry?.id ?? 0)
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Section.self, from: response ?? Data())
            self?.sections.removeAll()
            self?.sections.append(contentsOf: data?.data ?? [])
            HomeVC.sections.removeAll()
            HomeVC.sections.append(contentsOf: data?.data ?? [])
            self?.collectionView.reloadData()
            self?.collectionView2.reloadData()
            self?.tableView.reloadData()
            self?.tableViewB.reloadData()

        }
    }
    func fetchSliders() {
        startLoading()
        ApiManager.instance.paramaters["type"] = 2
        ApiManager.instance.connection(.getSlider, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(Slider.self, from: response ?? Data())
            self?.sliders.removeAll()
            self?.sliders.append(contentsOf: data?.data ?? [])
            if self?.sliders.count ?? 0 > 0 {
                Timer.scheduledTimer(timeInterval: 5.0, target: self ?? (Any).self, selector: #selector(HomeVC.loadNextController), userInfo: nil, repeats: true)
                self?.setPageViewController()
            }
         
        }
    }
    private func setPageViewController(){
        let pageVC = UIStoryboard.init(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "promoPageVCC") as? UIPageViewController
        pageVC?.dataSource
            = self
        
        self.pageControl.numberOfPages = sliders.count
        let firstController = getViewController(atIndex: 0)
        pageVC?.setViewControllers([firstController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController = pageVC
        
        self.addChild(self.pageViewController!)
        self.pageView.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParent: self)
    }
    
    
    fileprivate func getViewController(atIndex index: Int) -> PromoContentVC {
        let promoContentVC = UIStoryboard.init(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentVC
        
        promoContentVC.imageName = sliders[index].file
        promoContentVC.titleImage = sliders[index].title
        promoContentVC.descImage = sliders[index].desc
        promoContentVC.pageIndex = index
        
        return promoContentVC
        
    }
    @objc private func loadNextController(){
        currentIndex += 1
        
        if currentIndex == sliders.count {
            currentIndex = 0
        }
        
        let nextController = getViewController(atIndex: currentIndex)
        
        self.pageViewController?.setViewControllers([nextController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        self.pageControl.currentPage = currentIndex
        
    }
    
  
   
}
//extension uipageviewcontrollerdatasource

extension HomeVC : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        if index == 0 || index == NSNotFound {
            return getViewController(atIndex: sliders
                .count - 1)
            
            //0 |1 |2 |0|1|2.......
        }
        index  -= 1
        return getViewController(atIndex: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == sliders.count {
            return getViewController(atIndex: 0)
        }
        return getViewController(atIndex: index)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            var counter = 0
            sections.forEach { (item) in
                if item.style == 3 {
                    counter += 1
                }
            }
            return counter
        }
        else  {
            var counter = 0
            sections.forEach { (item) in
                if item.style == 4 {
                    counter += 1
                }
            }
            return counter
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.AgentCell , for: indexPath) as! AgentsCell
            sections.forEach { (item) in
                if item.style == 3 {
                    cell.imageAgent.setImage(url: item.image)
                    cell.agentLbl.text = item.name
                    cell.agentDesc.text = item.desc
                    cell.bkImageAgent.setImage(url: item.cover)
                }
            }
            return cell
            
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: Identifiers.AgentCell, for: indexPath) as! AgentsCell
            sections.forEach { (item) in
                if item.style == 4 {
                    cell2.imageAgentB.setImage(url: item.image)
                    cell2.agentLblB.text = item.name
                    cell2.agentDescB.text = item.desc
                    cell2.bkImageB.setImage(url: item.cover)
                }
            }
            
            
            return cell2
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            let storyboard = UIStoryboard(name: "Drivers", bundle: nil)
            let navC = storyboard.instantiateViewController(withIdentifier: "navC") as! UINavigationController
            //            let driversMapVC = (navC.viewControllers[0] as? DriversMapVC)!
            self.present(navC, animated: false, completion: nil)
        } else {
            sections.forEach { (item) in
                if item.style == 4 {
                    let vc = controller(CategoryVC.self, storyboard: .category)
                    vc.section = item.id
                    vc.sectionName = item.name
                    vc.style = .red
                    push(vc)
                }
            }
            
        }
    }
}
extension HomeVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            var counter = 0
            sections.forEach { (item) in
                if item.style == 2 {
                    counter += 1
                }
            }
            return counter
        } else {
            var counter = 0
            sections.forEach { (item) in
                if item.style == 1 {
                    counter += 1
                }
            }
            return counter
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.cell(type: HomeShopCell.self, indexPath, register: false)
            sections.forEach { (item) in
                if item.style == 2 {
                    cell.categoryImage.setImage(url: item.cover)
                    cell.titleLbl.text = item.name
                    cell.descLbl.text = item.desc
                    cell.imageIcon.setImage(url: item.image)
                }
            }
            
            return cell
        }
        let cell2 = collectionView.cell(type: HomeShopCell.self, indexPath, register: false)
        sections.forEach { (item) in
            if item.style == 1 {
                cell2.categoryImage2.setImage(url: item.cover)
                cell2.titleLbl.text = item.name
                cell2.descLbl.text = item.desc
                cell2.imageIcon2.setImage(url: item.image)
            }
        }
        
        
        
        
        return cell2
    }
    
    //(10) d lly btt7km f 7gm l cell lyy htt3rdly 7sb 7gm l telephone lly h3rd 3leh
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //bt3rd l width bta3 l mobile
        let width = view.frame.width
        //(11) moheeeeemaaaaa ->na2s 30 34an 3ndi 10 3lymen w 10 3l 4mal w 10 l min soacing fhib2o 30 lly homa m4 mst5dmnhom,y3ni hn5li l width bta3 l collectionView m2som 3la 5lyten bs y3ni hn3rd 5lyten hna bs f msa7a l collectionView kolha
        let cellWidth = (width - 200)
        let cellHeight =   cellWidth * 1
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            sections.forEach { (item) in
                let vc = controller(CategoryVC.self, storyboard: .category)
                vc.section = item.id
                vc.sectionName = item.name
                if item.style == 2 {
                    vc.style = .orange
                    push(vc)
                }
            }
        } else {
            sections.forEach { (item) in
                let vc = controller(CategoryVC.self, storyboard: .category)
                vc.section = item.id
                vc.sectionName = item.name
                if item.style == 1 {
                    vc.style = .green
                    push(vc)
                }
            }
        }
    }
}
