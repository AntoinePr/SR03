//
//  RegisterViewController.swift
//  GameApp
//
//  Created by Antoine P on 09/06/2017.
//  Copyright © 2017 Antoine Protard. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func creerCompteButton(_ sender: Any) {
        
        let login = loginTextField.text
        let password = passwordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        
        // Check for empty field
        if ((login?.isEmpty)! || (password?.isEmpty)! || (repeatPassword?.isEmpty)!) {
            
            // Display alert message
            displayMyAlertMsg(msg: "Certains des champs sont vides")
            return
        }
        
        // Check if password match
        if(password != repeatPassword) {
            
            // Display alert message
            displayMyAlertMsg(msg: "Les mots de passe ne correspondent pas")
            return
        }
        
        // Store data
        
        // Checks if the login is already used
        
        // Display success message and change of view
        let myAlert = UIAlertController(
            title: "Alerte",
            message: "Votre compte a été créé avec succès",
            preferredStyle: UIAlertControllerStyle.alert
        )
    
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
