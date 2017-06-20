//
//  Purshases.swift
//  GameApp
//
//  Created by Antoine P on 28/05/2017.
//  Copyright © 2017 Antoine Protard. All rights reserved.
//

import UIKit

// Represente un achat générique d'un client

class Purchase {
    
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
