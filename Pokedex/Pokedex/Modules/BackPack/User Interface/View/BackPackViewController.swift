//
//  BackPackViewController.swift
//  Pokedex
//
//  Created by Ivan Aibar Romero on 4/11/17.
//  Copyright © 2017 Ivan Aibar Romero. All rights reserved.
//

import UIKit
import RealmSwift
import StatefulViewController

protocol BackPackViewInterface: class {
    func pokemonSearched(pokemon: Pokemon?, code: Int, canCatchIt: Bool)
    func pokemonsGotten(pokemons: Results<Pokemon>)
}

class BackPackViewController: UIViewController, BackPackViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, StatefulViewController {
    
    // MARK: Constants
    
    let CellNibName = "PokemonCollectionViewCell"
    
    // MARK: Instance Variables
    
    var presenter: BackPackModuleInterface!
    var collectionViewLayout: PokemonCollectionFlow!
    var pokemons: Results<Pokemon>?
    var refreshControl: UIRefreshControl!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var cvBackPack: UICollectionView!
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getBackPackPokemons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState() // Initializing view state flow
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "BackPack.Search".localized(), style: .plain, target: self, action: #selector(searchPokemon))
        self.title = "BackPack.Title".localized()
        
        // Setup collection view
        collectionViewLayout = PokemonCollectionFlow()
        cvBackPack.collectionViewLayout = collectionViewLayout
        cvBackPack.register(UINib.init(nibName: CellNibName, bundle: nil), forCellWithReuseIdentifier: CellNibName)
        
        // Delegates
        cvBackPack.delegate = self
        cvBackPack.dataSource = self
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(getBackPackPokemons), name: NSNotification.Name(rawValue: Constants.Notifications.Reload), object: nil)
        
        // Setup refresh control
        refreshControl = UIRefreshControl()
        cvBackPack.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(getBackPackPokemons), for: .valueChanged)
        cvBackPack.addSubview(refreshControl)
        
        // Setup placeholder views
        let emptyController = BackPackEmptyViewController(nibName: "BackPackEmptyViewController", bundle: nil)
        emptyController.view.frame = view.frame
        emptyView = emptyController.view
    }
    
    // MARK: Public functions
    
    func getBackPackPokemons() {
        if (lastState == .Loading) { return }
        startLoading()
        presenter.getBackPackPokemons()
    }
    
    func searchPokemon() {
        ProgressView.sharedInstance.showProgressView(view: self.view)
        navigationItem.rightBarButtonItem!.isEnabled = false
        presenter.searchPokemon()
    }
    
    // MARK: StatefulViewController functions
    
    func hasContent() -> Bool {
        return self.pokemons != nil ? self.pokemons!.count > 0 : true
    }
    
    // MARK: UICollectionView datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons != nil ? self.pokemons!.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellNibName, for: indexPath) as! PokemonCollectionViewCell
        cell.configureCell(pokemon: self.pokemons![indexPath.row])
        
        return cell
    }
    
    // MARK: UICollectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showPokemonDetail(pokemon: self.pokemons![indexPath.row])
    }
    
    // MARK: BackPackViewInterface
    
    func pokemonSearched(pokemon: Pokemon?, code: Int, canCatchIt: Bool) {
        ProgressView.sharedInstance.hideProgressView()
        navigationItem.rightBarButtonItem!.isEnabled = true
        
        if Helper.isHttpOk(code: code), pokemon != nil {
            let alert = PokemonAlert(pokemon: pokemon!, canCatchIt: canCatchIt)
            alert.show(animated: true)
        }else {
            let alert = UIAlertController(title: "Common.AlertHeader".localized(), message: "Common.Error".localized(), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Common.Retry".localized(), style: .default, handler: { action in
                self.searchPokemon()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func pokemonsGotten(pokemons: Results<Pokemon>) {
        refreshControl.endRefreshing()
        endLoading(animated: true, error: nil, completion: nil)
        self.pokemons = pokemons
        cvBackPack.reloadData()
    }
}
