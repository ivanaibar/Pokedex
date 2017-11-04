//
//  BackPackModuleInterface.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation

protocol BackPackModuleInterface : class {
    func searchPokemon()
    func getBackPackPokemons()
    func showPokemonDetail(pokemon: Pokemon)
}
