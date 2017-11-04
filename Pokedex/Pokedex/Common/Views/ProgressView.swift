//
//  ProgressView.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import UIKit

public class ProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    public class var sharedInstance: ProgressView {
        struct Static {
            static let instance: ProgressView = ProgressView()
        }
        return Static.instance
    }
    
    public func showProgressView(view: UIView) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        
        progressView.frame = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        progressView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = CGPoint.init(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        activityIndicator.color = UIColor.white
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        view.bringSubview(toFront: containerView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        containerView.removeFromSuperview()
    }
}
