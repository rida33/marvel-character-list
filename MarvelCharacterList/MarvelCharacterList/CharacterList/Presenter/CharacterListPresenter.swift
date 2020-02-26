//
//  CharacterListPresenter.swift
//  MarvelCharacterList
//
//  Created by BABA  Rida on 26/02/2020.
//  Copyright © 2020 BABA  Rida. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON
import CryptoSwift

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
        let url = "http://gateway.marvel.com:80/v1/public/characters"
        let publicKey = "0fb108bb11b5bbcb35aa5db0e72edbaf"
        let privateKey = "ae00b9333b894d7bb15f7479d30c2302b86c375d"
        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + privateKey + publicKey).md5()
        
        if (oldSearch != search) {
            self.delegate?.deleteCharacters()
            self.offset = 0
        }
        oldSearch = search
        var params: Parameters = [
            "apikey": publicKey,
            "ts": ts,
            "hash": hash,
            "limit" : 10,
            "offset" : self.offset,
        ]
        if (search != "") {
            params["nameStartsWith"] = search
        }
        Alamofire.request(url, parameters: params).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    let JSONData = JSON(json)
                    JSONData["data"]["results"].arrayValue.forEach {
                        let name = $0["name"].stringValue
                        let bio = $0["description"].stringValue
                        let imgUrl = $0["thumbnail"]["path"].stringValue + "/standard_medium." + $0["thumbnail"]["extension"].stringValue
                        let character = Character(name: name, bio: bio, imgUrl: imgUrl)
                        self.delegate?.getNewCharacterSuccess(character: character)
                    }
                    
                    self.offset += 10
                }
                break
            case .failure(_):
                break
            }
        }
    }
}
