
import Foundation
import UIKit

class UserRoot: Decodable {
    public static var storeUserDefaults: String = "USER_DATA_DEFAULT"
    public static var storeUserObject: String = "USER_DATA_OBJECT"
    public static var storeRememberUser: String = "USER_LOGIN_REMEMBER"
    public static var loginTimeStamp: String = "LOGIN_TIMESTAMP"

    var user: User?
    var expires_in: Int?
    var token: String?
    var refresh_token: String?
    var message: String?
    var loginTimeStamp: Int?

    public static func convertToModel(response: Data?) -> UserRoot {
        do {
            let data = try JSONDecoder().decode(self, from: response ?? Data())
            return data
        } catch {
            return UserRoot()
        }
    }

    public static func save(response: Data?, remember: Bool = true) {
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = Int(TimeInterval(timestamp))
        
        UserDefaults.standard.set(response, forKey: storeUserDefaults)
        UserDefaults.standard.set(myTimeInterval, forKey: loginTimeStamp)
        if remember {
            UserDefaults.standard.set(true, forKey: storeRememberUser)
        }
        
    }
    public static func fetch() -> UserRoot? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        
        guard let userObject = UserDefaults.standard.data(forKey: storeUserObject) else { return user }
        guard let object = try? JSONDecoder().decode(User.self, from: userObject) else { return user}
        if object.id != nil {
             user.user = object
        }
       
        return user
    }
    public static func token() -> String? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user.token
    }
    public static func setData(data: User?) {
        let user = UserRoot.fetch()
        user?.user = User()
        user?.user?.id = data?.id
        user?.user?.name = data?.name
        user?.user?.email = data?.email
        user?.user?.phone = data?.phone
        user?.user?.lat = data?.lat
        user?.user?.lng = data?.lng
        user?.user?.isDriver = data?.isDriver
        user?.user?.image = data?.image
        user?.user?.gender = data?.gender
        user?.user?.birth_date = data?.birth_date
        user?.user?.age = data?.age
        user?.user?.City = data?.City
        
        let data = try? JSONEncoder().encode(user?.user)
        UserDefaults.standard.set(data, forKey: storeUserObject)
       
    }
    public static func loginAlert(closure: HandlerView? = nil) {
        var handler: HandlerView?
        if closure == nil {
            handler = {
                guard let vcr = Constants.loginNav else { return }
                UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
            }
        } else {
            handler = closure
        }
       
        let alert = UIAlertController(title: "alert.lan".localized, message: "you_must_be_logged_in.lan".localized,
                                      preferredStyle: UIAlertController.Style.alert)
        let acceptAction = UIAlertAction(title: "sure.lan".localized, style: .default) { (_) -> Void in
            handler?()
        }
        let cancelAction = UIAlertAction(title: "cancel.lan".localized, style: .default) { (_) -> Void in
        }
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

class User: Codable {

    var email: String?
    var name: String?
    var id: Int?
    var image: String?
    var lname: String?
    var phone: String?
    var status: Int?
    var lat: String?
    var lng: String?
    var isDriver: Bool?
    var age: Int?
    var gender: Int?
    var birth_date: String?
    var City: City?
    
    class City: Codable {
        var name: String?
        var id: Int?
    }
}

class UserData: Codable {
    var data: User?
}
