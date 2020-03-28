//
//  UIImage.swift
//  D2020
//
//  Created by Macbook on 2/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

extension UIImage {
  static func localImage(_ name: String, template: Bool = false) -> UIImage {
    var image = UIImage(named: name)!
    if template {
      image = image.withRenderingMode(.alwaysTemplate)
    }
    return image
  }
}
