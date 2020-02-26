//
//  CharacterController.swift
//  MarvelCharacterList
//
//  Created by BABA  Rida on 26/02/2020.
//  Copyright © 2020 BABA  Rida. All rights reserved.
//

import UIKit

class CharacterController : UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var character : Character = Character(name: "", bio: "", imgUrl: "")
    var imageProfile : UIImage = UIImage(systemName: "hourglass")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = character.bio
        nameLabel.text = character.name
        profilePicture.image = imageProfile
    }
}
