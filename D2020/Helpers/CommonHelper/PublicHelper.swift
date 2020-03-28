import CoreData
import UIKit
 public func call(text: String?) {
    if var mobile = text {
        mobile = mobile.cut(charSplit: " ", charWith: "")
        guard let number = URL(string: "tel://" + mobile) else { return }
        UIApplication.shared.open(number)
    } else {
        return
    }
 }
 public func sms(text: String?) {
    if let mobile = text {
        guard let number = URL(string: "sms://" + mobile) else { return }
        UIApplication.shared.open(number)
    } else {
        return
    }
 }
 public func sendSms(text: String?) {
    sms(text: text)
 }
 public func phoneCall(text: String?) {
    call(text: text)
 }
 public func sendMail(text: String?) {
    if let email = text {
        let string = "mailto:"+email
        if let url = URL(string: string) {
            UIApplication.shared.open(url)
        }
    } else {
        return
    }
 }
 public func openUrl(text: String?) {
    if let url = text {
        let url = URL(string: url)!
        UIApplication.shared.open(url)
    } else {
        return
    }
 }
 public func shareApp(items: [Any] = []) {
    var sharing = items
    sharing.append(Constants.itunesURL)
    let activityVC = UIActivityViewController(activityItems: sharing, applicationActivities: nil)
    //New Excluded Activities Code
    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
    //
    let view = UIApplication.topMostController()
    activityVC.popoverPresentationController?.sourceView = view.view
    view.present(activityVC, animated: true, completion: nil)
 }

import CoreLocation
import MapKit
struct NavigateMap {
    var lat: Double?
    var lng: Double?
    var title: String?
    
    func openMapForPlace(delegate: UIViewController? = nil) {
        
        let installedNavigationApps : [String] = ["Apple Maps","Google Maps", "Cancel"] // Apple Maps is always installed
        
        let alert = UIAlertController(title: "Selection", message: "Select Navigation App", preferredStyle: .actionSheet)
        for app in installedNavigationApps {
            let button = UIAlertAction(title: app, style: .default) { (action) in
                if action.title == "Apple Maps" {
                    self.openAppleMap()
                }else if action.title == "Google Maps" {
                    self.openGoogleMap()
                }
            }
            
            alert.addAction(button)
        }
        delegate?.present(alert, animated: true, completion: nil)
        
    }
    func openAppleMap(){
        let latitude: CLLocationDegrees = lat ?? 0
        let longitude: CLLocationDegrees = lng ?? 0
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = title
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    func openGoogleMap(){
        let (lat, lng, _) = (self.lat ?? 0, self.lng ?? 0, self.title ?? "")
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:
                "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving")!)
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
    
}
