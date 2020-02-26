//
//  CharacterListController.swift
//  MarvelCharacterList
//
//  Created by BABA  Rida on 26/02/2020.
//  Copyright © 2020 BABA  Rida. All rights reserved.

import UIKit

class CharacterListController : UIViewController, UISearchBarDelegate {
    
    var presenter: CharacterListPresenter?
    var characters: [Character] = []
    let cellReuseIdentifier = "CharacterCell"
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = CharacterListPresenter(delegate: self)
        self.characterTableView.delegate = self
        self.characterTableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        characters = [Character(name: "rida", bio: "rida est le plus grand des héros", imgUrl: ""),
        Character(name: "pony", bio: "pony est le héros des transports", imgUrl: "")]
        self.characterTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.getCharacters(search: searchBar.prompt ?? "")
    }
}

extension CharacterListController : CharacterListDelegate {
    func getNewCharacterSuccess(character: Character) {
        characters.append(character)
        self.characterTableView.reloadData()
    }

    func deleteCharacters() {
        characters = []
    }
}

extension CharacterListController : UITableViewDataSource, UITableViewDelegate {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:CharacterCell = self.characterTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CharacterCell
        cell.setCharacter(character : characters[indexPath.row])
        cell.loadProfileImage()
        cell.delegate = self
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
}
