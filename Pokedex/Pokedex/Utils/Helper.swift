//
//  Helper.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class Helper {
    class func isHttpOk(code: Int) -> Bool {
        return code >= 200 && code < 300
    }
    
    class func setImageFromImageView(imageView: UIImageView, url: String) {
        imageView.af_setImage(withURL: NSURL.init(string: url)! as URL, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(qos: .background), imageTransition: UIImageView.ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false, completion: { (response) in
            if let value = response.result.value {
                imageView.image = value
            }
        })
    }
}
