//
//  TopSales.swift
//  GameApp
//
//  Created by Antoine P on 28/05/2017.
//  Copyright © 2017 Antoine Protard. All rights reserved.
//

import UIKit

// Represente un achat générique d'un client

class TopSales {
    
    var jeu: String
    var nb_ventes: Int
    
    init(jeu: String, nb_ventes: Int) {
        self.jeu = jeu
        self.nb_ventes = nb_ventes
    }
}
