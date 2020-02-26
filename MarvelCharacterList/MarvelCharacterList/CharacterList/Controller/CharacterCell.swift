//
//  CharacterCell.swift
//  MarvelCharacterList
//
//  Created by BABA  Rida on 26/02/2020.
//  Copyright © 2020 BABA  Rida. All rights reserved.

import UIKit
import Alamofire

class CharacterCell : UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    weak var delegate:CharacterListController!
    private var imageLoaded : Bool = false
    private var character : Character = Character(name: "", bio: "", imgUrl: "")
    
    func setCharacter(character: Character) {
        self.character = character
        name.text = character.name
    }
    
    @IBAction func buttonTouched(_ sender: Any) {
        // OPEN Character info page
    }
    
    func loadProfileImage() {
        Alamofire.request(character.imgUrl).responseData { (response) in
            if response.error == nil {
                if let data = response.data {
                    self.profilePicture.image = UIImage(data: data)
                }
            }
        }
    }
}
