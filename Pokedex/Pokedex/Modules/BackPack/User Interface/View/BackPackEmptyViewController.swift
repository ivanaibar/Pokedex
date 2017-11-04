//
//  BackPackEmptyViewController.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import UIKit

class BackPackEmptyViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var lbEmpty: UILabel!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private functions
    
    private func setupView() {
        lbEmpty.text = "BackPack.Empty".localized()
    }

}
