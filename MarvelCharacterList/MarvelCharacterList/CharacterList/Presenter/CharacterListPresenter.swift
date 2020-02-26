//
//  CharacterListPresenter.swift
//  MarvelCharacterList
//
//  Created by BABA  Rida on 26/02/2020.
//  Copyright © 2020 BABA  Rida. All rights reserved.

protocol CharacterListDelegate: class {
    func getNewCharacterSuccess(character: Character)
    func deleteCharacters()
}

class CharacterListPresenter {
    weak var delegate: CharacterListDelegate?
    var oldSearch : String = ""
    var offset : Int = 0
    
    init(delegate: CharacterListDelegate) {
        self.delegate = delegate
    }
    
    func getCharacters(search: String = "") {
        //check if the search is the same | if not delete characters and set offset to 0
        // set oldSearch = search
        // get 10 characters with param search, 10 for the limit, and offset
        // set offset to offset +=10
    }
}
