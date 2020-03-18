//
//  RegisterLocationVC.swift
//  D2020
//
//  Created by Macbook on 2/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import MapKit
class RegisterLocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
currentLocation()
        
    }
    func currentLocation()  {
        let latitude:CLLocationDegrees = 29.979335899999995
        let longitude:CLLocationDegrees = 31.1278879
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate:regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan:regionSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.openInMaps(launchOptions: options)
        
    }

}
