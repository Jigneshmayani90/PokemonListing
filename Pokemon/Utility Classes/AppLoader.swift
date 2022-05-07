//
//  AppLoader.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

private let vLoader = UIView()

private let activityIndicatorView = UIActivityIndicatorView.init(style: .medium)

struct AppLoader {
    
    static func startLoaderToAnimating(_ isMask: Bool = true)  {
        
        DispatchQueue.main.async {
            if isMask {
                vLoader.frame = UIScreen.main.bounds
                vLoader.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                appDelegate.window?.addSubview(vLoader)
            }
            
            activityIndicatorView.color = UIColor.blue
            activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
            appDelegate.window?.addSubview(activityIndicatorView)
            
            activityIndicatorView.startAnimating()
        }
    }
    
    static func stopLoaderToAnimating() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            activityIndicatorView.stopAnimating()
            vLoader.removeFromSuperview()
        }
    }
}

