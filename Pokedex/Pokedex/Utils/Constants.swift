//
//  Constants.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        static let EndPoint = "http://pokeapi.co/api/v2/pokemon/"
    }
    
    struct Pokemon {
        static let Id = "id"
        static let Name = "name"
        static let Weight = "weight"
        static let Height = "height"
        static let Sprites = "sprites"
        static let FrontDefault = "front_default"
        static let DateCatched = "date_catched"
        static let BaseExperience = "base_experience"
        static let Types = "types"
        static let PkType = "type"
        static let Order = "order"
    }
    
    struct Notifications {
        static let Reload = "reload"
    }
}
