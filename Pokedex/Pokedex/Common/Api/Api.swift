//
//  Api.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import AlamofireImage

final class Api {
    
    static let sharedInstance = Api()
    
    private init(){
        manager.session.configuration.timeoutIntervalForRequest = 30
    }
    
    private let manager = Alamofire.SessionManager.default

    /// Search a Pokemon by its Id (between 1-1000)
    ///
    /// - Parameter completion: A block object to be executed when the request operation finishes (returning a Pokemon object if succeeded)
    func searchPokemon(completion: @escaping(DataResponse<Pokemon>) -> ()) {
    
        let randomInt = Int.randomNumber(min: 1, 1000)
        let url = Constants.API.EndPoint + String(randomInt)
        
        manager.request(url, method: .get, parameters: nil, headers: nil).validate().responseObject { (response: DataResponse<Pokemon>) in
            completion(response)
        }
    }
    
    func getPokemonImage(url: String, completion: @escaping(DataResponse<Image>) -> ()) {
        manager.request(url, method: .get, parameters: nil, headers: nil).validate().responseImage { response in
            completion(response)
        }
    }
}
