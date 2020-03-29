//
//  MapVC.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/21/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var typesView: UIView!
    @IBOutlet weak var allTypesView: UIView!
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var rentView: UIView!
    @IBOutlet weak var driversView: UIView!
    @IBOutlet weak var familyView: UIView!
    
    @IBOutlet weak var searchLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        centerMapOnUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        getStoresAndAddToMap()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(typesLblTapped(tapGestureRecognizer:)))
        typeLbl.isUserInteractionEnabled = true
        typeLbl.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func getStoresAndAddToMap() {
//        for store in storesData {
//            let storeId = store._id
//            
//            guard let location = store.location else { return }
//            if let lat = location.lat, let lng = location.lng {
//                
//                let annotation = CustomAnnotation()
//                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//                annotation.id = storeId
//                
//                // check store type and change annotation image
//                annotation.image = #imageLiteral(resourceName: "map")
//                
//                annotation.coordinate = coordinate
//                annotation.title = store.name
//                annotation.subtitle = location.address ?? "Store Address"
//                
//                self.mapView.addAnnotation(annotation)
//                
//            }
//        }
        zoom(toFitAnnotationsFromMapView: mapView)
    }
    
    @objc func typesLblTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        openTypesView()
    }
    
    func openTypesView() {
        typesView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.typesView.transform = .identity
        }) { (finished) in
            
        }
        
        typesView.alpha = 1
        mapView.isUserInteractionEnabled = false
    }
    
    func closeTypesView(typeSelected: String) {
        typeLbl.text = typeSelected
        
        typesView.transform = .identity
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {() -> Void in
            self.typesView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.typesView.alpha = 0
            self.mapView.isUserInteractionEnabled = true
        })
    }
    
    @IBAction func dropSearchBtn(_ sender: Any) {
        
    }
    
    @IBAction func dropTypesBtn(_ sender: Any) {
        openTypesView()
    }
    
    @IBAction func allTypesBtn(_ sender: Any) {
        closeTypesView(typeSelected: "كل الاقسام")
        
        allTypesView.backgroundColor = #colorLiteral(red: 1, green: 0.6831588745, blue: 0, alpha: 1)
        storesView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        driversView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        familyView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
    }
    
    @IBAction func storesBtn(_ sender: Any) {
        closeTypesView(typeSelected: "المحلات")
        
        allTypesView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        storesView.backgroundColor = #colorLiteral(red: 1, green: 0.6831588745, blue: 0, alpha: 1)
        rentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        driversView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        familyView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
    }
    
    @IBAction func rentBtn(_ sender: Any) {
        closeTypesView(typeSelected: "للايجار")
        
        allTypesView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        storesView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rentView.backgroundColor = #colorLiteral(red: 0.3312796354, green: 0.7220976353, blue: 0.4870316386, alpha: 1)
        driversView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        familyView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
    }
    
    @IBAction func driversBtn(_ sender: Any) {
        closeTypesView(typeSelected: "المناديب")
        
        allTypesView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        storesView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        driversView.backgroundColor = #colorLiteral(red: 0.1530038714, green: 0.6730028987, blue: 0.8579127192, alpha: 1)
        familyView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
    }
    
    @IBAction func familyBtn(_ sender: Any) {
        closeTypesView(typeSelected: "الاسر المنتجه")
        
        allTypesView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        storesView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.8470588235)
        driversView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        familyView.backgroundColor = #colorLiteral(red: 1, green: 0.340308845, blue: 0.3424271345, alpha: 1)
    }
    
    @IBAction func chatBtn(_ sender: Any) {
    }
    
    @IBAction func sideMenuBtn(_ sender: Any) {
    }
    
    
}



extension MapVC: MKMapViewDelegate {
    
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
