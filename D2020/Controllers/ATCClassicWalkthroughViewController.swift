//
//  ATCClassicWalkthroughViewController.swift
//  D2020
//
//  Created by Macbook on 2/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class ATCClassicWalkthroughViewController: UIViewController {
  @IBOutlet var containerView: UIView!
  @IBOutlet var imageContainerView: UIView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  
  let model: ATCWalkthroughModel
  
  init(model: ATCWalkthroughModel,
       nibName nibNameOrNil: String?,
       bundle nibBundleOrNil: Bundle?) {
    self.model = model
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = UIImage(named: model.icon)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
//    imageView.tintColor = .white
    imageContainerView.backgroundColor = .white
    
    titleLabel.text = model.title
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
    titleLabel.textColor = .white
    
    subtitleLabel.attributedText = NSAttributedString(string: model.subtitle)
    subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
    subtitleLabel.textColor = .white
    
    containerView.backgroundColor = UIColor(red: 235, green: 236, blue: 234, alpha: 1)
  }
}
