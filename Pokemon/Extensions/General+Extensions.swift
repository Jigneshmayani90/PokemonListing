//
//  General+Extensions.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit
import Combine

extension CGRect {
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = nil) -> UIViewController? {
        var baseVC = base
        if baseVC == nil {
            baseVC = appDelegate.window?.rootViewController
        }
        if let nav = baseVC as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = baseVC?.presentedViewController {
            return topViewController(base: presented)
        }
        return baseVC
    }
}

extension Publisher {
    // MARK: - Subscribe And Received Data From Server -
    func subscribeAndReceived(_ qos: DispatchQoS = .background) -> AnyPublisher<Self.Output, Self.Failure> {
        subscribe(on: DispatchQueue( label: "rrcombine.queue.\(qos)", qos: qos, attributes: [.concurrent], target: nil))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    // MARK: - Deferred -
    func setDeferred() -> AnyPublisher<Self.Output, Self.Failure> {
        Deferred { self }
            .eraseToAnyPublisher()
    }
}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
