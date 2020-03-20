import UIKit

private var textFieldUnderlineActive: [UITextField: UIColor] = [:]
private var textFieldUnderline: [UITextField: UIColor] = [:]

extension UITextField {

    
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var underline: UIColor? {
        get {
            return self.underline
        }
        set {
            if newValue != nil {
                //self.underlined(color: newValue!)
                self.addBottomBorder(withColor: newValue!)
                textFieldUnderline[self] = newValue!
            }
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var underlineActive: UIColor? {
        get {
            return self.underlineActive
        }
        set {
            if newValue != nil {
                self.delegate = self
                textFieldUnderlineActive[self] = newValue!
            }
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var autoReturn: Bool {
        get {
            return self.autoReturn
        }
        set {
            if newValue {
                self.delegate = self
                _ = self.textFieldShouldReturn(self)
            }
        }
    }
}
extension UITextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let activeUnderline = textFieldUnderlineActive[textField] else { return }
        textField.underlined(color: activeUnderline)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let underline = textFieldUnderline[textField] else { return }
        textField.underlined(color: underline)
    }
}


extension UISearchBar {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var textColor: UIColor {
        get {
            return self.textColor
        }
        set {
            self.textField?.textColor = newValue
        }
    }
  
    private func getViewElement<T>(type: T.Type) -> T? {
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    func getSearchBarTextField() -> UITextField? {
        return getViewElement(type: UITextField.self)
    }
    func setTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    func setTextFieldColor(color: UIColor) {
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    func setPlaceholderTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
}
