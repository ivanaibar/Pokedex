//
//  RootWireframe.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe : NSObject {
    func showRootViewController(viewController: UIViewController, window: UIWindow) {
        let navigationController = UINavigationController.init()
        navigationController.viewControllers = [viewController]
        
        UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }, completion: nil)
    }
}
