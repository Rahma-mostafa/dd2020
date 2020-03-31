import Alamofire

class BaseApi: Downloader, Paginator, Alertable {
    let url = Constants.url
    var paramaters: [String: Any] = [:]
    var headers: [String: String] = [:]
    var isHttpRequestRun: Bool = false

    override init() {
        super.init()
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
        
        if let token = UserRoot.token() {
            headers["Authorization"] = "Bearer "+token
        } else {
            headers["Authorization"] = ""
        }
 

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
        self.headers = [:]
        setupObject()
    }
    func initURL(method: String, type: HTTPMethod) -> String {
        var url = ""
        var methodFullUrl = method
        if type == .get {
            methodFullUrl = initGet(method: method)
        } else {
        }
        if method.contains("http") {
            url = methodFullUrl
        } else {
            url = self.url+methodFullUrl
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
                        let data = try? JSONDecoder().decode(BaseModel.self, from: response.data ?? Data())
                        if data?.message != nil {
                            self.makeAlert(data?.message ?? "", closure: {})
                        } else {
                            self.makeAlert("not_found.lan".localized, closure: {})
                        }
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
    func uploadFile(_ method: String , type: HTTPMethod, file: [String: URL?], completionHandler: @escaping (Data?) -> ()) {
        
        self.isHttpRequestRun = true
    
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()

        Alamofire.upload(multipartFormData: { multipartFormData in
            file.forEach { (fileDic) in
                if let url = fileDic.value {
                    multipartFormData.append(url, withName: fileDic.key)
                }
            }

            for (key, value) in paramters {
                let string = value as? String
                multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                self.presenting()
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                    var progress = self.progressView.progress
                    progress = progress*100
                    self.label.text = "\(Int(progress))"+"%"
                })
                
                upload.responseJSON { response in
                    self.restore()
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
                            let data = try? JSONDecoder().decode(BaseModel.self, from: response.data ?? Data())
                            if data?.message != nil {
                                self.makeAlert(data?.message ?? "", closure: {})
                            } else {
                                self.makeAlert("not_found.lan".localized, closure: {})
                            }
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
    func uploadMultiFiles(_ method: String , type: HTTPMethod, files: [URL], key: String, file: [String: URL?]? = nil, completionHandler: @escaping (Data?) -> ()) {
        
        self.isHttpRequestRun = true
    
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()

        Alamofire.upload(multipartFormData: { multipartFormData in
            var counter = 0
            files.forEach({ (item) in
                multipartFormData.append(item, withName: "\(key)[\(counter)]")
                counter += 1
            })
            if file != nil {
                file?.forEach({ (fileData) in
                    if let url = fileData.value {
                        multipartFormData.append(url, withName: "\(fileData.key)")
                    }
                })
            }
            for (key, value) in paramters {
                let string = value as? String
                multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                self.presenting()
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                    var progress = self.progressView.progress
                    progress = progress*100
                    self.label.text = "\(Int(progress))"+"%"
                })
                
                upload.responseJSON { response in
                    self.restore()
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
                                let data = try? JSONDecoder().decode(BaseModel.self, from: response.data ?? Data())
                                if data?.message != nil {
                                    self.makeAlert(data?.message ?? "", closure: {})
                                } else {
                                    self.makeAlert("not_found.lan".localized, closure: {})
                                }
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
