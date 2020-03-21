//
//  HomeVC.swift
//  D2020
//
//  Created by Macbook on 2/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit



struct menuA {
    var imageMenu:String?
    var TitleMenu:String?
}

struct TableViewCategory {
    var name:String?
    var tableViewImg: String?
    var tableViewDescription: String?
    var bkImage:String?
    
}

class HomeVC: BaseController {
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewB: UITableView!
    
    
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
  
    
    //Variables SlideMenu
    var isSideMenuHidden = true

   
    
    
    
    //Variables slideShow
    
    var pageViewController:UIPageViewController?
    let arrayPageImage = ["slideShow","d2020logo","WELCOME2"]
    var currentIndex = 0
    
    //Variables -> collectionView
    
//    var categories = [Category]()
    var selectedCategory : String?
    
    var tableViewItems :[TableViewCategory] = [TableViewCategory(name: "المناديب", tableViewImg: "Group 501", tableViewDescription: "اكثر من ٦٠ مندوب",bkImage: "lucian-alexe-afDu-GuxjjM-unsplash")]
    
    var tableViewItemsB : [TableViewCategory] = [TableViewCategory(name: "الاسرة النتجة", tableViewImg: "Group 500", tableViewDescription: "اكثر من ٣٠٠ منتج من الاسر المنتجة", bkImage: "perry-grone-lbLgFFlADrY-unsplash")]
    
    var items:[Item] = [Item( name:"المحلات", imageName: "mostafa-meraji-X0yKdR_F9rM-unsplash",description: "اكثر من ٥٠٠ محل", imageIcon: "shop")]
    
    var items2 :[Item] = [Item(name: "للايجار", imageName: "dmitry-demidko-eBWzFKahEaU-unsplash", description: "اكثر من ٣٠٠ محل للايجار", imageIcon: "Group 499")]

    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        
        //SlideMenu
//        profileImageView.layer.cornerRadius = 35
//        viewConstraint.constant = -450
        
                
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HomeVC.loadNextController), userInfo: nil, repeats: true)
        setPageViewController()
       
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewB.delegate = self
        tableViewB.dataSource = self
        
    
        
    }
    
    @IBAction func search(_ sender: Any) {
    }
    @IBAction func chat(_ sender: Any) {
    }
    
    
      private func setPageViewController(){
        let pageVC = UIStoryboard.init(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "promoPageVCC") as? UIPageViewController
          pageVC?.dataSource
           = self
          
         let firstController = getViewController(atIndex: 0)
        pageVC?.setViewControllers([firstController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController = pageVC
        
        self.addChild(self.pageViewController!)
        self.pageView.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParent: self)
      }
      
      
fileprivate func getViewController(atIndex index: Int) -> PromoContentVC {
          let promoContentVC = UIStoryboard.init(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentVC
    
        promoContentVC.imageName = arrayPageImage[index]
        promoContentVC.pageIndex = index
    
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

extension HomeVC : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        if index == 0 || index == NSNotFound {
            return getViewController(atIndex: arrayPageImage
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
        if index == arrayPageImage.count {
            return getViewController(atIndex: 0)
        }
        return getViewController(atIndex: index)
    }
}

extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
        
        
        
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             
              if tableView == self.tableView {
                  return tableViewItems.count
                      }
            else  {
                  return tableViewItemsB.count

              }
          }

           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if tableView == self.tableView {

            
            let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.AgentCell , for: indexPath) as! AgentsCell
            cell.imageAgent.image = UIImage(named: tableViewItems[indexPath.row].tableViewImg!)
            cell.agentLbl.text = tableViewItems[indexPath.row].name
            cell.agentDesc.text = tableViewItems[indexPath.row].tableViewDescription
            cell.bkImageAgent.image = UIImage(named: tableViewItems[indexPath.row].bkImage!)
                             
            return cell
                                        
            }
            else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: Identifiers.AgentCell, for: indexPath) as! AgentsCell
            cell2.imageAgentB.image = UIImage(named: tableViewItemsB[indexPath.row].tableViewImg!)
            cell2.agentLblB.text = items2[indexPath.item].name
            cell2.agentDescB.text = tableViewItemsB[indexPath.row].tableViewDescription
            cell2.bkImageB.image = UIImage(named: tableViewItemsB[indexPath.row].bkImage!)

                  
                  
                  return cell2
                     }
           
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if tableView == self.tableView {
                let storyboard = UIStoryboard(name: "Drivers", bundle: nil)
                let navC = storyboard.instantiateViewController(withIdentifier: "navC") as! UINavigationController
    //            let driversMapVC = (navC.viewControllers[0] as? DriversMapVC)!
                self.present(navC, animated: false, completion: nil)
            }
        }
}
extension HomeVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return items.count
        }
        return items2.count

       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.cell(type: HomeShopCell.self, indexPath, register: false)
            cell.categoryImage.image = UIImage(named: items[indexPath.item].imageName!)
            cell.titleLbl.text = items[indexPath.item].name
            cell.descLbl.text = items[indexPath.item].description
            cell.imageIcon.image = UIImage(named: items[indexPath.item].imageIcon!)
            return cell
        }
        let cell2 = collectionView.cell(type: HomeShopCell.self, indexPath, register: false)
        cell2.categoryImage2.image = UIImage(named: items2[indexPath.item].imageName!)
        cell2.titleLbl.text = items2[indexPath.item].name
        cell2.descLbl.text = items2[indexPath.item].description
        cell2.imageIcon2.image = UIImage(named: items2[indexPath.item].imageIcon!)

        
        
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
        
//<<<<<<< HEAD
              //  performSegue(withIdentifier: Segues.ToProducts, sender: self)

    //=======
            selectedCategory = items[indexPath.item].name
                    selectedCategory = items[indexPath.item].description
            //       selectedCategory = UIImage(named: items[indexPath.item].imageName!)
                    
                            //performSegue(withIdentifier: Segues.ToProducts, sender: self)
        
//>>>>>>> origin/Drivers-Ahmad-1
        }
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == Segues.ToProducts {
//                if let destination = segue.destination as? CategoryVC {
//                    destination.category = selectedCategory
//                }
//            }
//        }
}
    
    
    


