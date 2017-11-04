//
//  BackPackInteractor.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

protocol BackPackInteractorInput : class {
    func searchPokemon()
    func getBackPackPokemons()
}

protocol BackPackInteractorOutput : class {
    func pokemonSearched(pokemon: Pokemon?, code: Int, canCatchIt: Bool)
    func pokemonsGotten(pokemons: Results<Pokemon>)
}

class BackPackInteractor : BackPackInteractorInput {
    
    // MARK: Instance Variables
    
    weak var output: BackPackInteractorOutput!
    
    // MARK: BackPackInteractorInput
    
    func searchPokemon() {
        Api.sharedInstance.searchPokemon(completion: { (response: DataResponse<Pokemon>) in
            switch response.result {
            case .success(let pokemon):
                // Check if already exists in local DB
                let pokemonExists = DataManager.sharedInstance.pokemonExists(pokemon: pokemon)
                self.output.pokemonSearched(pokemon: pokemon, code: (response.response?.statusCode)!, canCatchIt: !pokemonExists)
            case .failure(_):
                if let response = response.response {
                    self.output.pokemonSearched(pokemon: nil, code: response.statusCode, canCatchIt: false)
                }else {
                    self.output.pokemonSearched(pokemon: nil, code: 500, canCatchIt: false)
                }
            }
        })
    }
    
    func getBackPackPokemons() {
        let pokemons = DataManager.sharedInstance.getPokemons()
        self.output.pokemonsGotten(pokemons: pokemons)
    }
}
