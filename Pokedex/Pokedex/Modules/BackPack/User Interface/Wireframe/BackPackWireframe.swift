//
//  BackPackWireframe.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit

protocol BackPackWireframeWireframeInput {
    func showPokemonDetail(pokemon: Pokemon)
}

class BackPackWireframe: NSObject, BackPackWireframeWireframeInput {
    
    // MARK: Instance Variables
    
    var backPackViewController: BackPackViewController!
    var backPackPresenter: BackPackPresenter!
    var rootWireframe : RootWireframe!
    var pokemonDetailWireframe: PokemonDetailWireframe!
    
    // MARK: Public
    
    override init() {
        super.init()
        
        let backPackInteractor = BackPackInteractor()
        
        backPackPresenter = BackPackPresenter()
        backPackPresenter.interactor = backPackInteractor
        backPackPresenter.wireframe = self
        
        backPackInteractor.output = backPackPresenter
    }
    
    func presentBackPackInterfaceFromWindow(_ window: UIWindow) {
        
        backPackViewController = BackPackViewController(nibName: "BackPackViewController", bundle: nil)
        backPackViewController.presenter = backPackPresenter
        backPackPresenter.view = backPackViewController
        
        rootWireframe.showRootViewController(viewController: backPackViewController, window: window)
    }
    
    func showPokemonDetail(pokemon: Pokemon) {
        pokemonDetailWireframe = PokemonDetailWireframe()
        pokemonDetailWireframe.showPokemonDetailInterfaceFromViewController(controller: backPackViewController, pokemon: pokemon)
    }
}
