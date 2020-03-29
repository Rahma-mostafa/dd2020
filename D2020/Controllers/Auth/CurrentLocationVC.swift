//
//  CurrentLocationVC.swift
//  D2020
//
//  Created by Macbook on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import GoogleMaps

class CurrentLocationVC: BaseController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var confirmBtn: RoundedButton!
    
    var locationHelper: LocationHelper?
    var googleHelper: GoogleMapHelper?
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
    }
   
    func setup() {
        googleHelper = .init()
        //googleHelper?.delegate = self
        googleHelper?.mapView = mapView
        googleHelper?.zoom = .inStreets
        googleHelper?.delegate = self
        locationHelper = .init()
        locationHelper?.onUpdateLocation = { location in
            self.googleHelper?.updateCamera(lat: location?.latitude ?? 0, lng: location?.longitude ?? 0)
        }
        locationHelper?.currentLocation()
        
        confirmBtn.setTitle(Localizations.confirm.localized, for: .normal)
        confirmBtn.UIViewAction {
            self.startLoading()
            ApiManager.instance.paramaters["lat"] = self.locationHelper?.lat ?? 0
            ApiManager.instance.paramaters["lang"] = self.locationHelper?.lng ?? 0
            ApiManager.instance.connection(.updateLat, type: .post) { (response) in
                self.stopLoading()
                let data = try? JSONDecoder().decode(UserData.self, from: response ?? Data())
                UserRoot.setData(data: data?.data)
                guard let vc = UIStoryboard.init(name: Storyboards.main.rawValue, bundle: nil).instantiateInitialViewController() else { return }
                self.push(vc)
            }
        }
    }
}

extension CurrentLocationVC: GoogleMapHelperDelegate {
    func didChangeCameraLocation(lat: Double, lng: Double) {
        self.googleHelper?.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
    }
}
