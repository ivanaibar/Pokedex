//
//  Int+Additions.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation

extension Int {
    static func randomNumber(min: Int, _ max: Int) -> Int {
        guard min < max else { return min }
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
}
