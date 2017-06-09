//
//  FirstViewController.swift
//  GameApp
//
//  Created by Antoine P on 23/05/2017.
//  Copyright © 2017 Antoine Protard. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class ConnexionViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connexionButtonTapped(_ sender: Any) {
        
        let login = loginTextField.text
        let password = passwordTextField.text
        
        // Check for empty field
        if ((login?.isEmpty)! || (password?.isEmpty)!) {
            
            // Display alert message
            displayMyAlertMsg(msg: "Certains des champs sont vides")
            return
        }
        
        let parameters: Parameters = [
            "login": login ?? "",
            "mdp": password ?? ""
        ]
        
        Alamofire.request(
            "http://localhost:8080/Projet_SR03/rest/connexion",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let statusCode = response.response?.statusCode
                if (response.error as? AFError) != nil {
                    switch statusCode! {
                    case 401:
                        self.displayMyAlertMsg(msg: "Identifiant ou mot de passe invalides")
                        return
                    case 400..<500:
                        self.displayMyAlertMsg(msg: "Erreur d'URL")
                        return
                    case 500..<600:
                        self.displayMyAlertMsg(msg: "Serveur mommentanément indisponible")
                        return
                    default:
                        self.displayMyAlertMsg(msg: "Service mommentanément indisponible")
                        return
                    }
                } else if (response.error as? URLError) != nil {
                    self.displayMyAlertMsg(msg: "Service mommentanément indisponible")
                    return
                    
                } else if response.error == nil {
                    self.displayMyAlertMsg(msg: "Connexion réussie")
                    let json = JSON(response.result.value!)
                    print("=====================")
                    print(json)
                    let token = json["token"].string!
                    UserDefaults.standard.set(token, forKey: "token")
                    print("=====================")
                    print("TOKEN:", token)
                }
        }
    }
    
    func displayMyAlertMsg(msg: String) {
        let myAlert = UIAlertController(
            title: "Alerte:",
            message: msg,
            preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }

}

