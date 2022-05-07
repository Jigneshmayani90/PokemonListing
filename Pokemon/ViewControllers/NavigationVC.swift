//
//  NavigationVC.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

class NavigationVC: UINavigationController {

    // MARK: - Variable -
    
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf: NavigationVC? = self
        interactivePopGestureRecognizer?.delegate = weakSelf!
        delegate = weakSelf!
        //isNavigationBarHidden = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UIGestureRecognizerDelegate -
extension NavigationVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count > 1 {
            return true
        } else {
            return false
        }
    }
}

// MARK: - UINavigationControllerDelegate -
extension NavigationVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { (context) in
                print("Is cancelled: \(context.isCancelled)")
                if !context.isCancelled {
                    //NotificationCenter.default.post(name: .swipeBack, object: nil)
                }
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        /*if viewController is SideMenuVC {
            interactivePopGestureRecognizer!.isEnabled = false
        } else {*/
            interactivePopGestureRecognizer!.isEnabled = true
        //}
    }
}
