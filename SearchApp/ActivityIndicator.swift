//
//  ActivityIndicator.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import Foundation
import UIKit


public protocol ActivityIndicatorPresenter {
    
    var activityIndicator: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.color = UIColor.gray
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80) //or whatever size you would like
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
