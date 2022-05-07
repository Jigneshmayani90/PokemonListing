//
//  BaseVC.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

public class BaseVC: UIViewController {
        
    // MARK: - Variable -
    
    
    // MARK: - View Life Cycle -
    override open func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        modalPresentationStyle = .fullScreen
        view.tintAdjustmentMode = .normal
        view.backgroundColor = UIColor.white
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        AppLoader.stopLoaderToAnimating()
        super.viewWillDisappear(animated)
    }
    /*
    // MARK: - Pull To Refresh -
    @objc private func pullToRefresh() {
        refreshControl.beginRefreshing()
    }
    */
        
    // MARK: - Memory Release -
    deinit {
        print("Memory Release : \(String(describing: self))\n" )
    }
}
