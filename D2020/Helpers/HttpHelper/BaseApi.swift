import Alamofire

class BaseApi: Paginator, Alertable {
    let url = Constants.url
    var paramaters: [String: Any] = [:]
    var headers: [String: String] = [:]
    var isHttpRequestRun: Bool = false

    init() {
        setupObject()
    }
    func refresh() {
        setupObject()
        paginate()
    }
    func setupObject() {
        headers["version"] = Constants.version
        headers["Device"] = Constants.deviceId
        headers["lang"] = Localizer.current
        if UserDefaults.standard.bool(forKey: "LOGIN") {
            if let token = UserDefaults.standard.string(forKey: "access_token") {
                headers["Authorization"] = "Bearer "+token
            } else {
                headers["Authorization"] = ""
            }
        }
        headers["Authorization"] = "Bearer "+"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzZmNGYxNzgxOTM5YTQxYmEwOGJlOTU2ODRiZjg4YzhkMDFjYzIzNzhlYTlhM2I4NmRkMTczOWI1Yzk0MWY2Nzk2MGI0OTY2OGMyZjcxNjkiLCJpYXQiOjE1ODUwODE2OTgsIm5iZiI6MTU4NTA4MTY5OCwiZXhwIjoxNjE2NjE3Njk4LCJzdWIiOiIxMzQiLCJzY29wZXMiOltdfQ.Xn3K7KBKkphoKEmiNub_GREbhChI8kepjqrPdllrPbpJAMI1viDhMRDSOCnTwUUuGPTQZcczOzo3Ta3TIPQEEI5O0AEkvrQR7ZFDfCMF3GFkgOnro9eRzksSsZeKFr3JnRy6d8s50DtxlXpgKUG2dcr3Zglc8r71WSGGsrJIkTqtjPHytDQzQlm4vt0ggLxF7GAMN1WcVqx6Egh7v1TGyCaXDUvK9id84iWw_Mxju9hEgUMqOtAxWIX3wCE7CUp7QKX7y9quMH46Koj-yV0A1gSisEgsrUEFE21bLZgkeZzKOaElAZnSCwfzzsmM-6m6QwX6d6cpeRjztv7Qzt7l8ZZdvpxV0nZaO9_jvW74BmqK-WYpZoFWOIigDNwaTBRQ-uG9Z0Voi0gxBaoYgsgKNQ7_nRmfJ_LBAA3PpJ3Dw5AxjwhIu4EFC79yiHMuMtzC-6GwuIdFAx-aV2oovu6rPJeV-X8Hy-GM5nJVz9tzeqqklxui2BxlVwxuepNXSB6L0zIsJoELiWApaA_gHVJUr46_Yyr9lbcaNipE4OvgGVBxCr6WGorItwI-N8rYrRE0LfO8VmBEIUe_juBf6s8FkVKpWY7GeQIPEKfrNgt_pp5p0SvJUFnD4qEH4Om5obP2bzYtfGjxSE0szoC8qtIWYVhqQF14KPAprxyP2ER8b5s"

        paramaters["lang"] = Localizer.current
        paramaters["device_type"] = Constants.deviceType
        if let devicetoken = UserDefaults.standard.string(forKey: "deviceToken") {
            paramaters["device_token"] = devicetoken
        } else {
            paramaters["device_token"] = "nil"
        }
        paramaters["device_id"] = Constants.deviceId

    }
    func resetObject() {
        self.paramaters = [:]
        setupObject()
    }
    func initURL(method: String, type: HTTPMethod) -> String {
        var url = ""
        if type == .get {
            let methodFull = initGet(method: method)
            url = self.url+methodFull
        } else {
            url = self.url+method
        }
        return url
    }
    func connection(_ method: String, type: HTTPMethod,
                    completionHandler: @escaping (Data?) -> Void) {
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        self.resetObject()
        Alamofire.request(safeUrl(url: url), method: type, parameters: paramters, headers: self.headers)
            .responseJSON { response in
                print(response.result.value ?? "")
                self.isHttpRequestRun = false
                switch response.result {
                //case .success(let value)
                case .success:
                    switch response.response?.statusCode {
                    case 200?:
                        completionHandler(response.data)
                    case 201?:
                        completionHandler(response.data)

                    case 400?:
                        UIApplication.topViewController()?.stopLoading()
                        self.setErrorMessage(data: response.data)
                    //completionHandler(nil)
                    case 401?:
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert("the_login_is_required.lan".localized, closure: {
                            guard let vcr = Constants.loginNav else { return }
                            UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
                        })
                    case 404?:
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert("not_found.lan".localized, closure: {})
                    case 422?:
                        UIApplication.topViewController()?.stopLoading()
                        self.setErrorMessage(data: response.data)
                    //completionHandler(nil)
                    case .none:
                        break
                    case .some(let error):
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert(String(error), closure: {})
                    }
                case .failure(let error):
                    UIApplication.topViewController()?.stopLoading()
                    self.makeAlert(error.localizedDescription, closure: {})
                }
        }
    }
    func uploadFile(_ method: String , type: HTTPMethod, file: [String: URL], completionHandler: @escaping (Data?) -> ()) {
        
        self.isHttpRequestRun = true
    
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()

        Alamofire.upload(multipartFormData: { multipartFormData in
            file.forEach { (fileDic) in
                multipartFormData.append(fileDic.value, withName: fileDic.key)
            }

            for (key, value) in paramters {
                let string = value as? String
                multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    
                })
                
                upload.responseJSON { response in
                    self.isHttpRequestRun = false
                    print(response.result.value ?? "")
                    switch response.result {
                    //case .success(let value)
                    case .success:
                        switch response.response?.statusCode {
                        case 200?:
                            completionHandler(response.data)
                        case 201?:
                            completionHandler(response.data)

                        case 400?:
                            UIApplication.topViewController()?.stopLoading()
                            self.setErrorMessage(data: response.data)
                        //completionHandler(nil)
                        case 401?:
                            UIApplication.topViewController()?.stopLoading()
                            self.makeAlert("the_login_is_required.lan".localized, closure: {
                                guard let vcr = Constants.loginNav else { return }
                                UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
                            })
                        case 404?:
                            UIApplication.topViewController()?.stopLoading()
                            self.makeAlert("not_found.lan".localized, closure: {})
                        case 422?:
                            UIApplication.topViewController()?.stopLoading()
                            self.setErrorMessage(data: response.data)
                        //completionHandler(nil)
                        case .none:
                            break
                        case .some(let error):
                            UIApplication.topViewController()?.stopLoading()
                            self.makeAlert(String(error), closure: {})
                        }
                    case .failure(let error):
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert(error.localizedDescription, closure: {})
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                UIApplication.topViewController()?.stopLoading()
                self.makeAlert(encodingError.localizedDescription, closure: {})
            }
        }
    }
    func uploadMultiFiles(_ method: String , type: HTTPMethod, files: [[String: URL]], completionHandler: @escaping (Data?) -> ()) {
        
        self.isHttpRequestRun = true
    
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()

        Alamofire.upload(multipartFormData: { multipartFormData in
            var counter = 0
            files.forEach({ (item) in
                item.forEach { (file) in
                    multipartFormData.append(file.value, withName: "\(file.key)[\(counter)]")
                }
                counter += 1
            })
            for (key, value) in paramters {
                let string = value as? String
                multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
//                    self.progressView.setProgress(progress.fractionCompleted.float, animated: true)
//                    var progress = self.progressView.progress
//                    progress = progress*100
//                    self.label.text = progress.int.string+"%"
                })
                
                upload.responseJSON { response in
                  
                    self.isHttpRequestRun = false
                    print(response.result.value ?? "")
                    switch response.result {
                    //case .success(let value)
                    //case .success(let value)
                        case .success:
                            switch response.response?.statusCode {
                            case 200?:
                                completionHandler(response.data)
                            case 201?:
                                completionHandler(response.data)

                            case 400?:
                                UIApplication.topViewController()?.stopLoading()
                                self.setErrorMessage(data: response.data)
                            //completionHandler(nil)
                            case 401?:
                                UIApplication.topViewController()?.stopLoading()
                                self.makeAlert("the_login_is_required.lan".localized, closure: {
                                    guard let vcr = Constants.loginNav else { return }
                                    UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
                                })
                            case 404?:
                                UIApplication.topViewController()?.stopLoading()
                                self.makeAlert("not_found.lan".localized, closure: {})
                            case 422?:
                                UIApplication.topViewController()?.stopLoading()
                                self.setErrorMessage(data: response.data)
                            //completionHandler(nil)
                            case .none:
                                break
                            case .some(let error):
                                UIApplication.topViewController()?.stopLoading()
                                self.makeAlert(String(error), closure: {})
                            }
                        case .failure(let error):
                            UIApplication.topViewController()?.stopLoading()
                            self.makeAlert(error.localizedDescription, closure: {})
                        }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                UIApplication.topViewController()?.stopLoading()
                self.makeAlert(encodingError.localizedDescription, closure: {})
            }
        }
    }
}
