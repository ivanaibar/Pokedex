//
//  PokemonAlert.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import UIKit
import AlamofireImage

class PokemonAlert: UIView, Modal {
    
    // MARK: Constants
    let ImageViewSize: CGFloat = 50
    let DialogSpacing: CGFloat = 8
    let LabelHeight: CGFloat = 30
    let ScreenSpacing: CGFloat = 64
    let ButtonHeight: CGFloat = 44
    
    // MARK: Instance variables

    var backgroundView = UIView()
    var dialogView = UIView()
    var pokemon: Pokemon?
    
    // MARK: Initializers
    
    convenience init(pokemon: Pokemon, canCatchIt: Bool) {
        self.init(frame: UIScreen.main.bounds)
        initialize(pokemon: pokemon, canCatchIt: canCatchIt)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(pokemon: Pokemon, canCatchIt: Bool) {
        
        self.pokemon = pokemon
        
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width - ScreenSpacing
        
        let titleLabel = UILabel(frame: CGRect(x: DialogSpacing, y: DialogSpacing, width: dialogViewWidth-(DialogSpacing*2), height: LabelHeight))
        titleLabel.text = pokemon.name
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        dialogView.addSubview(titleLabel)
        
        let imageView = UIImageView()
        imageView.frame.origin = CGPoint(x: dialogViewWidth / 2 - ImageViewSize / 2, y: titleLabel.frame.height + 15)
        imageView.frame.size = CGSize(width: ImageViewSize , height: ImageViewSize)
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        dialogView.addSubview(imageView)
        
        let weight = UILabel(frame: CGRect(x: DialogSpacing, y: imageView.frame.origin.y + ImageViewSize + DialogSpacing, width: dialogViewWidth - (DialogSpacing*2), height: LabelHeight))
        weight.text = "PokemonAlert.Weight".localized() + ": " + String(pokemon.weight)
        weight.textAlignment = .center
        weight.adjustsFontSizeToFitWidth = true
        dialogView.addSubview(weight)
        
        let height = UILabel(frame: CGRect(x: DialogSpacing, y: weight.frame.origin.y +
            weight.frame.size.height + DialogSpacing, width: dialogViewWidth - (DialogSpacing*2), height: LabelHeight))
        height.text = "PokemonAlert.Height".localized() + ": " + String(pokemon.height)
        height.textAlignment = .center
        height.adjustsFontSizeToFitWidth = true
        dialogView.addSubview(height)
        
        if canCatchIt {
            let catchButton = UIButton(type: .system)
            catchButton.frame = CGRect(x: DialogSpacing, y: height.frame.origin.y +
                height.frame.size.height + DialogSpacing, width: dialogViewWidth - (DialogSpacing*2), height: ButtonHeight)
            catchButton.setTitle("PokemonAlert.CatchIt".localized(), for: .normal)
            catchButton.addTarget(self, action: #selector(catchPokemon), for: .touchUpInside)
            dialogView.addSubview(catchButton)
        }else {
            let noCatch = UILabel(frame: CGRect(x: DialogSpacing, y: height.frame.origin.y +
                height.frame.size.height + DialogSpacing, width: dialogViewWidth - (DialogSpacing*2), height: LabelHeight))
            noCatch.text = "PokemonAlert.NoCatch".localized()
            noCatch.textAlignment = .center
            noCatch.adjustsFontSizeToFitWidth = true
            dialogView.addSubview(noCatch)
        }
        
        let catchSpacing = canCatchIt ? ButtonHeight : LabelHeight
        let leaveButton = UIButton(type: .system)
        leaveButton.frame = CGRect(x: DialogSpacing, y: height.frame.origin.y +
            height.frame.size.height + catchSpacing + DialogSpacing, width: dialogViewWidth - (DialogSpacing*2), height: ButtonHeight)
        leaveButton.setTitle("PokemonAlert.LeaveIt".localized(), for: .normal)
        leaveButton.addTarget(self, action: #selector(didTappedOnBackgroundView), for: .touchUpInside)
        dialogView.addSubview(leaveButton)
        
        let dialogViewHeight = titleLabel.frame.height + imageView.frame.height + weight.frame.height + height.frame.height + leaveButton.frame.height + catchSpacing + (DialogSpacing*7)
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width - ScreenSpacing, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
        
        getImage(pokemon: pokemon, imageView: imageView)
    }
    
    // MARK: Private functions
    
    private func getImage(pokemon: Pokemon, imageView: UIImageView) {
        if let urlString = pokemon.imageUrl?.frontDefault {
            Helper.setImageFromImageView(imageView: imageView, url: urlString)
        }
    }
    
    // MARK: Public functions
    
    func catchPokemon() {
        if self.pokemon != nil {
            DataManager.sharedInstance.createUpdatePokemon(pokemon: self.pokemon!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.Reload), object: nil, userInfo: nil)
            didTappedOnBackgroundView()
        }
    }
    
    func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
}
