//
//  MapAnnotationsView.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation
import MapKit

class DestinationLocation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D   // dynamic to track any change in this variable in real time
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
    
    
    
}


class DriverLocation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D   // dynamic to track any change in this variable in real time
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
     
}



class CustomAnnotation : NSObject, MKAnnotation {
    var id: String?
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    
    
    override init() {
        self.coordinate = CLLocationCoordinate2D()
        self.title = nil
        self.subtitle = nil
        self.image = nil
        self.id = nil
        
    }
}

class CustomAnnotationView: MKAnnotationView {
    var imageView: UIImageView!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.addSubview(self.imageView)
        
        self.imageView.layer.borderColor = #colorLiteral(red: 0.1411764706, green: 0.6078431373, blue: 0.8235294118, alpha: 1)
        self.imageView.layer.borderWidth = 0.5
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
    }
    
    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        
        set {
            self.imageView.image = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
