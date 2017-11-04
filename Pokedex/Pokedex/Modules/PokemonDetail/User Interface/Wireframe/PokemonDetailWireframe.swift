//
//  PokemonDetailWireframe.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit
import Hero

protocol PokemonDetailWireframeWireframeInput {
    
}

class PokemonDetailWireframe: NSObject, PokemonDetailWireframeWireframeInput {
    
    // MARK: Instance Variables
    
    var pokemonDetailViewController: PokemonDetailViewController!
    var pokemonDetailPresenter: PokemonDetailPresenter!
    
    // MARK: Public
    
    override init() {
        super.init()
        
        let pokemonDetailInteractor = PokemonDetailInteractor()
        
        pokemonDetailPresenter = PokemonDetailPresenter()
        pokemonDetailPresenter.interactor = pokemonDetailInteractor
        pokemonDetailPresenter.wireframe = self
        
        pokemonDetailInteractor.output = pokemonDetailPresenter
    }
    
    func showPokemonDetailInterfaceFromViewController(controller: UIViewController, pokemon: Pokemon) {
        pokemonDetailViewController = PokemonDetailViewController(nibName: "PokemonDetailViewController", bundle: nil)
        pokemonDetailViewController.presenter = pokemonDetailPresenter
        
        pokemonDetailPresenter.view = pokemonDetailViewController
        pokemonDetailPresenter.wireframe = self
        
        pokemonDetailViewController.pokemon = pokemon
        
        // Hero transition setup
        controller.navigationController!.isHeroEnabled = true
        controller.navigationController!.heroNavigationAnimationType = .fade
        
        controller.navigationController!.pushViewController(pokemonDetailViewController, animated: true)
    }
}
