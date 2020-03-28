//
//  WalkthroughPageViewController.swift
//  D2020
//
//  Created by Macbook on 2/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    // Mark: - Properties
    
    var pageHeading = ["اهلا بك في تطبيق D2O2O ","شراء المنتجات","عرض منتجاتك","بساطة التصفح "]
    var pageImages = ["maksim-zhashkevych-qXfLGt9nh2Y-unsplash","slideShow","online-store (1)","Group 452"]
    var pageSubHeading = ["تطبيق D2020 الافضل من فئته في عرض وشراء جميع المنتجات بانواعها في اي مكان واي وقت","يمكنك شراء المنتجات الان من تطبيقنا بشتى طرق الدفع والتصفح المسبق للمنتجات بانواعها","يمكنك الان عرض منتجاتك بجميع فئاتها للبيع باي سعر واي مكان في المملكة","مع تطبيقنا نضمن لك التصفح الامن لكل عملائنا مع نظام D2020 الفريد من نوعه"]
    
    var currentIndex = 0


    

    override func viewDidLoad() {
        super.viewDidLoad()
        //set the datasource to itself
        dataSource = self
        
        //Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }

    }
    
    // Mark: - Page View Controller DataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentVC).index
        index -= 1
        return contentViewController(at:index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as? WalkThroughContentVC)?.index
        index! += 1
        return contentViewController(at:index!)
    }
    
    // Mark: - Helper
    
    func contentViewController(at index: Int) -> WalkThroughContentVC? {
        if index < 0 || index >= pageHeading.count {
        return nil
    }
        
        //Create a new viewController & pass suitable data
        
//        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkThroughContentVC {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeading[index]
            pageContentViewController.subHeading = pageSubHeading[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
