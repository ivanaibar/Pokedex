//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import UIKit
import RealmSwift

protocol PokemonDetailViewInterface: class {

}

class PokemonDetailViewController: UIViewController, PokemonDetailViewInterface {
    
    // MARK: Instance Variables
    
    var presenter: PokemonDetailModuleInterface!
    var pokemon: Pokemon!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var ivPokemon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDateCatched: UILabel!
    @IBOutlet weak var lbWeight: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var lbBase: UILabel!
    @IBOutlet weak var lbTypes: UILabel!
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        populateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Private functions
    
    private func setupView() {
        // Setup Navbar
        self.title = pokemon.name
        
        ivPokemon.heroID = String(pokemon.id) // Hero transition setup
    }
    
    private func populateData() {
        
        if let urlString = pokemon.imageUrl?.frontDefault {
            Helper.setImageFromImageView(imageView: ivPokemon, url: urlString)
        }
        
        lbName.text = pokemon.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: pokemon.dateCatched as Date)
        lbDateCatched.text = "PokemonDetail.DateCatched".localized() + ": " + dateString
        
        lbWeight.text = "PokemonAlert.Weight".localized() + ": " + String(pokemon.weight)
        lbHeight.text = "PokemonAlert.Height".localized() + ": " + String(pokemon.height)
        lbBase.text = "PokemonDetail.Base".localized() + ": " + String(pokemon.baseExperience)
        
        var typesArray = [String]()
        for types in pokemon.types {
            if let type = types.type {
                typesArray.append(type.name)
            }
        }
        lbTypes.text = "PokemonDetail.Types".localized() + ": " + typesArray.joined(separator: ", ")
    }
    
    // MARK: Public functions
    
    // MARK: PokemonDetailViewInterface
    
}
