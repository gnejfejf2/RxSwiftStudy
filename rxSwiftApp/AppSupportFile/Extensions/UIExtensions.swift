import UIKit
import Combine

extension UIView {
    enum VerticalLocation {
          case bottom
          case top
          case left
          case right
      }

    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.8, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -10, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 10, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCornersWithColor(corners: UIRectCorner, radius: CGFloat , color : CGColor) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.mask = mask
        
        //setup Border for Mask
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = 2
        borderLayer.strokeColor = color
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
     
    
    func makeChips(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
  
    func makeChipShadow(color : UIColor = .black , shadowOpacity : Float = 0.08){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: self.layer.cornerRadius).cgPath
//        SearchBox.layer.shadowColor =  UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 1
    }
    
}
public extension CALayer {

    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {

      
        
        
        
        for edge in arr_edge {

            let border = CALayer()
            border.name = "masklayer"

            switch edge {

            case UIRectEdge.top:

                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
             
              //  border.cornerRadius = 3
                break

            case UIRectEdge.bottom:

                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                //border.cornerRadius = 3
                break

            case UIRectEdge.left:

                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
              
                break

            case UIRectEdge.right:

                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                border.cornerRadius = 3
                border.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                break

            default:

                break

            }

            border.backgroundColor = color.cgColor;
        
            
            self.addSublayer(border)
        }
      
    }

}




extension UIViewController {
    func keyboardDown(){
        self.view.endEditing(true)
    }
}

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
    
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextView } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
    
}
extension UITextField {
    func addDoneButton(title: String, target: Any, selector: Selector) {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

extension UIApplication {
    
    
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}




extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
}




extension UIImage {
    func cropToBounds( width: Double, height: Double) -> UIImage {
        let image = self
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let returnImage: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return returnImage
    }
    
}
extension UIButton {
    func marginImageWithText(margin: CGFloat) {
        let halfSize = margin / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -halfSize, bottom: 0, right: halfSize)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: halfSize, bottom: 0, right: -halfSize)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSize, bottom: 0, right: halfSize)
    }
}
extension UIStackView {
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)

        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
}

//extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//}
//extension UINavigationController {
//    func popViewControllerWithHandler(completion: ()->()) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        self.popViewController(animated: true)
//        CATransaction.commit()
//    }
//    func pushViewController(viewController: UIViewController, completion: ()->()) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        self.pushViewController(viewController, animated: true)
//        CATransaction.commit()
//    }
//}
