//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class Pokemon : Object, Mappable {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var weight = 0
    dynamic var height = 0
    dynamic var imageUrl: Sprites?
    dynamic var dateCatched = NSDate()
    dynamic var baseExperience = 0
    var types: List<Types> = List() {
        willSet(newValue) { types.removeAll() }
        didSet { types.forEach(oldValue.append) }
    }
    dynamic var order = 0
    
    override static func primaryKey() -> String? {
        return Constants.Pokemon.Id
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map[Constants.Pokemon.Id]
        name <- map[Constants.Pokemon.Name]
        weight <- map[Constants.Pokemon.Weight]
        height <- map[Constants.Pokemon.Height]
        imageUrl <- map[Constants.Pokemon.Sprites]
        baseExperience <- map[Constants.Pokemon.BaseExperience]
        types <- (map[Constants.Pokemon.Types], ListTransform<Types>())
        order <- map[Constants.Pokemon.Order]
    }
}

class Sprites : Object, Mappable {
    dynamic var frontDefault = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        frontDefault <- map[Constants.Pokemon.FrontDefault]
    }
}

class Types : Object, Mappable {
    dynamic var type: Type?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        type <- map[Constants.Pokemon.PkType]
    }
}

class Type : Object, Mappable {
    dynamic var name = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map[Constants.Pokemon.Name]
    }
}
