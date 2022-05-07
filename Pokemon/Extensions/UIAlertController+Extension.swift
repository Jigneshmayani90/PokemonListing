//
//  UIAlertController+Extension.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

extension UIAlertController{
    
    class private func getAlertController(title : String, message : String?) -> UIAlertController {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.black]

        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont as [NSAttributedString.Key : Any])
        let messageAttrString = NSMutableAttributedString(string: message ?? "", attributes: messageFont as [NSAttributedString.Key : Any])

        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        
        return alertController
    }
    
    class func showAlert(title : String? = nil, message : String?, handler: ((UIAlertController) -> Void)? = nil){
        let alertController = getAlertController(title: title ?? "", message: message)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            handler?(alertController)
        }))
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}
