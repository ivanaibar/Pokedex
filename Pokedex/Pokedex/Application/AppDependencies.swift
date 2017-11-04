//
//  AppDependencies.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {

    var backPackWireframe: BackPackWireframe!
    
    // MARK: Public
    
    init() {
        let rootWireframe = RootWireframe()
        
        self.backPackWireframe = BackPackWireframe()
        self.backPackWireframe.rootWireframe = rootWireframe
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        backPackWireframe.presentBackPackInterfaceFromWindow(window)
    }
}
