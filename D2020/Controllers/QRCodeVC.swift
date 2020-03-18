//
//  QRCodeVC.swift
//  D2020
//
//  Created by Macbook on 3/2/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class QRCodeVC: UIViewController {
    
    
    @IBOutlet weak var qrCodeGenerated: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //QRCode
        
        let image = generateQRCode(from: "D2020")
        
        qrCodeGenerated.image = image
        
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
             let data = string.data(using: String.Encoding.ascii)
             
             if let filter = CIFilter(name: "CIQRCodeGenerator") {
                 filter.setValue(data, forKey: "inputMessage")
                 let transform = CGAffineTransform(scaleX: 3, y: 3)
                 
                 if let output = filter.outputImage?.transformed(by: transform) {
                     return UIImage(ciImage: output)
                 }
             }
             
             return UIImage()
         }
    

    
}
