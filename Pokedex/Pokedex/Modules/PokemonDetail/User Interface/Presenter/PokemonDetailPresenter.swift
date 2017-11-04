//
//  PokemonDetailPresenter.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import RealmSwift

class PokemonDetailPresenter : PokemonDetailModuleInterface, PokemonDetailInteractorOutput {
    
    // MARK: Instance Variables
    
    weak var view: PokemonDetailViewInterface!
    var interactor: PokemonDetailInteractorInput!
    var wireframe: PokemonDetailWireframe!
    
}
