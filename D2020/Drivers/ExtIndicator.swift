//
//  ExtIndicator.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadingIndicator(_ show: Bool, _ onImage: UIImage?) {
        let tag = 808404
        if show {
            self.image = nil
            let indicator = UIActivityIndicatorView()
            indicator.color = .white
            indicator.style = .medium
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.image = onImage
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
