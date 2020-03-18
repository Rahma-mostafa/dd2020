//
//  DriversMapVC.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import MapKit

class DriversMapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        centerMapOnUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        mapView.layer.cornerRadius = 20
        mapView.layer.masksToBounds = true
        viewDriversList(status: true)
    }
    
    
    fileprivate func viewDriversList(status: Bool) {
        // performSegue(withIdentifier: "toPlaces", sender: nil)
        if status == true {
            let bottomSheetVC = storyboard!.instantiateViewController(withIdentifier: "driversVC")
            bottomSheetVC.view.tag = 98
            self.addChild(bottomSheetVC)
            self.view.addSubview(bottomSheetVC.view)
            bottomSheetVC.didMove(toParent: self)
            
            let height = view.frame.height
            let width  = view.frame.width
            bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
            
        }else {
            for subview in view.subviews {
                if subview.tag == 98 {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0.0
                    }) { (finished) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
}



extension DriversMapVC: MKMapViewDelegate {
    
    func centerMapOnUserLocation() {
        mapView.userTrackingMode = .follow
        // user location
        let coordinate = CLLocationCoordinate2D(latitude: 30.0491629, longitude: 30.97615989999997)
        
        let annotation = DestinationLocation(coordinate: coordinate)
        mapView.addAnnotation(annotation)   // show dropped pin on map
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(coordinateRegion, animated: true)
        zoom(toFitAnnotationsFromMapView: mapView)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DestinationLocation {
            let identifier = "destination"
            var view: MKAnnotationView
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "destinationAnnotation")
            return view
        }else if let annotation = annotation as? CustomAnnotation {
            let identifier = "store"
            var view: CustomAnnotationView
            view = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = annotation.image
            
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.tintColor = #colorLiteral(red: 0.1411764706, green: 0.6078431373, blue: 0.8235294118, alpha: 1)
            view.isEnabled = true
            return view
        }
        guard annotation is MKPointAnnotation else { return nil }
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationId")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        annotationView.tintColor = #colorLiteral(red: 0.1411764706, green: 0.6078431373, blue: 0.8235294118, alpha: 1)
        annotationView.isEnabled = true
        annotationView.pinTintColor = #colorLiteral(red: 0.1411764706, green: 0.6078431373, blue: 0.8235294118, alpha: 1)
        annotationView.animatesDrop = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let pin = view.annotation as? CustomAnnotation {
            print("\(pin.id ?? "id"), \(pin.title ?? "title")")
            //            storeId = pin.id ?? ""
            performSegue(withIdentifier: "storeID", sender: self)
        }
    }
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "storeID" {
    //            if let detailPlaceVC = segue.destination as? DetailPlaceVC {
    //                detailPlaceVC.storeId = storeId
    //            }
    //        }
    //
    //    }
    
    func zoom(toFitAnnotationsFromMapView mapView: MKMapView) {
        if mapView.annotations.count == 0 {
            mapView.userTrackingMode = .follow
            return
        }
        
        mapView.userTrackingMode = .none
        var topLeftCoordinate = CLLocationCoordinate2D(latitude: -90, longitude: 180)
        var bottomRightCoordinate = CLLocationCoordinate2D(latitude: 90, longitude: -180)
        
        for annotation in mapView.annotations  {  /// where !annotation.isKind(of: DriverAnnotation.self)
            topLeftCoordinate.longitude = fmin(topLeftCoordinate.longitude, annotation.coordinate.longitude)
            topLeftCoordinate.latitude = fmax(topLeftCoordinate.latitude, annotation.coordinate.latitude)
            bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, annotation.coordinate.longitude)
            bottomRightCoordinate.latitude = fmin(bottomRightCoordinate.latitude, annotation.coordinate.latitude)
        }
        
        var region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(topLeftCoordinate.latitude - (topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 0.5
            , topLeftCoordinate.longitude + (bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 0.5)
            , span: MKCoordinateSpan(latitudeDelta: fabs(topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 2.0
                , longitudeDelta: fabs(bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 2.0 ))
        
        region = mapView.regionThatFits(region)
        mapView.setRegion(region, animated: true)
    }
    
}
