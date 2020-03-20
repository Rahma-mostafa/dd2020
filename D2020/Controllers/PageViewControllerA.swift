//
//  PageViewControllerA.swift
//  D2020
//
//  Created by Macbook on 3/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PageViewControllerA: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    lazy var orderViewController: [UIViewController] = {
        
        return [self.newVC(viewController: "sbRed"),
                self.newVC(viewController: "sbBlue"),
                self.newVC(viewController: "sbLast")]
        
    }()
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
     if let firstViewController = orderViewController.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               
                               animated: true,
                               completion: nil)
        }
        
        
        self.delegate = self
        configurePageControl()
    }
    
    func configurePageControl(){
        pageControl = UIPageControl(frame: CGRect(x: -150, y: UIScreen.main.bounds.maxY - 200, width: UIScreen.main.bounds.width, height: 50))
        
        pageControl.numberOfPages = orderViewController.count
        pageControl.currentPage = 0
        
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        
        pageControl.currentPageIndicatorTintColor = UIColor.systemOrange
        self.view.addSubview(pageControl)
    }
    
    func newVC(viewController:String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderViewController.index(of: viewController)else{
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
//            return orderViewController.last

            return nil
        }
        guard orderViewController.count > previousIndex else{
            return nil
        }
        return orderViewController[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderViewController.index(of: viewController)else{
                return nil
            }
            let nextIndex = viewControllerIndex  + 1
            
        guard orderViewController.count != nextIndex else {
//                return orderViewController.first

            return nil
        }
        guard orderViewController.count > nextIndex else{
                return nil
            }
            return orderViewController[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderViewController.index(of: pageContentViewController)!
    }
    
}
