//
//  BackPackPresenter.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import RealmSwift

class BackPackPresenter : BackPackModuleInterface, BackPackInteractorOutput {
    
    // MARK: Instance Variables
    
    weak var view: BackPackViewInterface!
    var interactor: BackPackInteractorInput!
    var wireframe: BackPackWireframe!
    
    // MARK: BackPackModuleInterface
    
    func searchPokemon() {
        interactor.searchPokemon()
    }
    
    func getBackPackPokemons() {
        interactor.getBackPackPokemons()
    }
    
    func showPokemonDetail(pokemon: Pokemon) {
        wireframe.showPokemonDetail(pokemon: pokemon)
    }
    
    // MARK: BackPackInteractorOutput
    
    func pokemonSearched(pokemon: Pokemon?, code: Int, canCatchIt: Bool) {
        if view != nil {
            view.pokemonSearched(pokemon: pokemon, code: code, canCatchIt: canCatchIt)
        }
    }
    
    func pokemonsGotten(pokemons: Results<Pokemon>) {
        if view != nil {
            view.pokemonsGotten(pokemons: pokemons)
        }
    }
}
