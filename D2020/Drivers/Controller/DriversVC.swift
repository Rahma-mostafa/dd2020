//
//  DriversVC.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class DriversVC: UIViewController {
    
    @IBOutlet weak var driversView: RoundedShadowView!
    @IBOutlet weak var tableView: UITableView!
    
    let fullView: CGFloat = 57
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 300
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
        
        let frame = self.view.frame
        let yComponent = self.partialView
        self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)  // height - 100
        
    }
    
    func prepareBackgroundView(){
        driversView.layer.borderWidth = 0.5
        driversView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        driversView.layer.cornerRadius = 20
        driversView.layer.shadowOffset = CGSize(width: 0, height: 1)
        driversView.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        driversView.layer.shadowRadius = 1
    }
    
    // Scrollable View from bottom
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                    
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: { [weak self] _ in
                if ( velocity.y < 0 ) {
                    self?.tableView.isScrollEnabled = true
                }
            })
        }
    }
    
}



extension DriversVC: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            tableView.isScrollEnabled = true
        } else {
            tableView.isScrollEnabled = true
        }
        
        return false
    }
    
}




extension DriversVC: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "الاقرب الي موقعك"
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let headerView = UIView()
//            headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//
//        let headerLabel = UILabel(frame: CGRect(x: 8, y: 8, width:
//            tableView.frame.width, height: 30))
//        headerLabel.textAlignment = .center
//            headerLabel.font = UIFont(name: "ArbFONTS-Sukar Bold.ttf", size: 15)
//            headerLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
//            headerLabel.sizeToFit()
//            headerView.addSubview(headerLabel)
//
//            return headerView
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "driversCell", for: indexPath) as? DriversCell {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSend", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
