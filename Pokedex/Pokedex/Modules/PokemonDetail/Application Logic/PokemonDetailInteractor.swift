//
//  PokemonDetailInteractor.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit

protocol PokemonDetailInteractorInput : class {

}

protocol PokemonDetailInteractorOutput : class {

}

class PokemonDetailInteractor : PokemonDetailInteractorInput {
    
    // MARK: Instance Variables
    
    weak var output: PokemonDetailInteractorOutput!
}
