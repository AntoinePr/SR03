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
        print("============================")
        print(UserDefaults.standard.bool(forKey: "isUserConnected"))
        print("============================")
        let connected = UserDefaults.standard.value(forKey: "isUserConnected") as! Bool
        if connected {
            print("============================")
            print("Trying to change view")
            print(connected)
            print("============================")
            self.performSegue(withIdentifier: "appEntryPoint", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connexionButtonTapped(_ sender: Any) {
        
        let userLogin = loginTextField.text
        let userPassword = passwordTextField.text
        
        // Check for empty field
        if ((userLogin?.isEmpty)! || (userPassword?.isEmpty)!) {
            
            // Display alert message
            displayMyAlertMsg(msg: "Certains des champs sont vides")
            return
        }
        
        makeConnexion(login: userLogin!, password: userPassword!, completion: {
            (isUserConnected, message) in
            UserDefaults.standard.set(isUserConnected, forKey: "isUserConnected")
            DispatchQueue.main.async {
                if isUserConnected {
                    // The connection is a success, we enter the app
                    
                    //self.definesPresentationContext = true
                    //self.performSegue(withIdentifier: "appEntryPoint", sender: self)
                    
                    //let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "MainToolBar")
                    //self.present(vc as! UITabBarController, animated: true, completion: nil)

                }else {
                    // In case the connection fails, we display the type of error
                    self.displayMyAlertMsg(msg: message)
                }
            }
        })
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
    
    func makeConnexion(login: String, password: String,
                       completion: @escaping (_ isUserConnected: Bool, _ message: String) -> ())
    {
        let parameters: Parameters = [
            "login": login ,
            "mdp": password 
        ]
        
        Alamofire.request(
            "http://localhost:8080/Projet_SR03/rest/connexion",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let statusCode = (response.response?.statusCode)!
                var returnMsg = "Success"
                if (response.error as? AFError) != nil {
                    switch statusCode {
                    case 401:
                        returnMsg = "Identifiant ou mot de passe invalides"
                        completion(false, returnMsg)
                    case 400..<500:
                        returnMsg = "Erreur d'URL"
                        completion(false, returnMsg)
                    default:
                        returnMsg = "Service mommentanément indisponible"
                        completion(false, returnMsg)
                    }
                } else if (response.error as? URLError) != nil {
                    returnMsg = "Service mommentanément indisponible"
                    completion(false, returnMsg)
                    
                } else if response.error == nil {
                    self.displayMyAlertMsg(msg: "Connexion réussie")
                    let json = JSON(response.result.value!)
                    let token = json["token"].string!
                    UserDefaults.standard.set(token, forKey: "token")
                    completion(true, returnMsg)
                }
        }
        
        return
    }


}

