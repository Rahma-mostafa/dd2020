//
//  CurrentLocationVC.swift
//  D2020
//
//  Created by Macbook on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import MapKit

class CurrentLocationVC: UIViewController {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        initLocation()


    }
    func initLocation(){
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }else if permiso == .denied {
            alertLocation(tit: "Error for your location", men: "check agein")
            
        }else if permiso == .restricted {
            
            alertLocation(tit: "Error for your location", men: "check agein")

            
        }else{
            guard  let currencyCoordinate = locationManager.location?.coordinate else {return}
            
            let region = MKCoordinateRegion.init(center: currencyCoordinate,latitudinalMeters: 500,longitudinalMeters: 500)
            
            mapView.setRegion(region, animated: true)
        
            
        }
        
    }
    func alertLocation(tit:String,men:String){
        
        let alert = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
extension CurrentLocationVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
    }
    
}
