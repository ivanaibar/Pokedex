//
//  DataManager.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class DataManager {
    
    static let sharedInstance = DataManager()
    var realm: Realm!
    
    init(){
        realm = try! Realm()
    }
    
    /// Retrieve all pokemons from local DB sorted by "order" key
    ///
    /// - Returns: A list of Pokemons
    func getPokemons() -> Results<Pokemon> {
        return realm.objects(Pokemon.self).sorted(byKeyPath: Constants.Pokemon.Order, ascending: true)
    }
    
    /// Store (or update) a pokemon on local DB
    ///
    /// - Parameter pokemon: A pokemon object to store
    func createUpdatePokemon(pokemon: Pokemon) {
        try! realm.write {
            pokemon.dateCatched = NSDate()
            realm.add(pokemon, update: true)
        }
    }
    
    /// Check if a pokemon exists on local DB
    ///
    /// - Parameter pokemon: A pokemon object to check if exists
    /// - Returns: Exists in local DB boolean
    func pokemonExists(pokemon: Pokemon) -> Bool {
        return realm.object(ofType: Pokemon.self, forPrimaryKey: pokemon.id) != nil
    }
}
