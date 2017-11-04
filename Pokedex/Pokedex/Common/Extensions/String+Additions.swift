//
//  String+Additions.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func localized() -> String {
        var path = Bundle.main.path(forResource: NSLocale.preferredLanguages[0], ofType: "lproj")
        if (path == nil) {
            path = Bundle.main.path(forResource: "Base", ofType: "lproj")
        }
        let bundle = Bundle.init(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }
}
