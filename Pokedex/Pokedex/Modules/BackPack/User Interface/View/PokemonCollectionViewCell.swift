//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPokemon: UIImageView!
    @IBOutlet weak var lbPokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ivPokemon.af_cancelImageRequest()
        ivPokemon.layer.removeAllAnimations()
        ivPokemon.image = nil
    }

    func configureCell(pokemon: Pokemon) {
        ivPokemon.heroID = String(pokemon.id) // Hero transition setup
        
        lbPokemon.text = pokemon.name
        
        if let urlString = pokemon.imageUrl?.frontDefault {
            Helper.setImageFromImageView(imageView: ivPokemon, url: urlString)
        }
    }
}
