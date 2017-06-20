//
//  AchatsTableViewController.swift
//  GameApp
//
//  Created by Antoine P on 28/05/2017.
//  Copyright © 2017 Antoine Protard. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON
import UIKit


class PurchasesTableViewController: UITableViewController {

    var purchases: [Purchase] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPurchases()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCells", for: indexPath)
        if !self.purchases.isEmpty {
            let purchase = purchases[indexPath.row]
            cell.textLabel?.text = purchase.title
            cell.detailTextLabel?.text = purchase.description
        }
        return cell
    }
    
    func loadPurchases() {
        self.getPurchases() { (json) -> () in
            for i in 0...(json.count-1) {
                self.purchases.append(Purchase(
                    title: json[i]["nom"].string!,
                    description: json[i]["description"].string!
                ))
            }
            self.tableView.reloadData()
        }
    }
    
    func getPurchases(completion: @escaping (_ json: JSON)->Void)
    {
        var token = "Token "
        //token += UserDefaults.standard.value(forKey: "token") as! String
        token += "7qj6nnih59mabub1qaloogcov0"
        let headers: HTTPHeaders = ["AUTHORIZATION": token]
        
        Alamofire.request("http://localhost:8080/Projet_SR03/rest/achats",
                          headers: headers)
            .responseJSON { response in
                
                let statusCode = response.response?.statusCode
                if (response.error as? AFError) != nil {
                    switch statusCode! {
                    case 400..<500:
                        print("Page not found.")
                        return
                    case 500..<600:
                        print("Serveur error.")
                        print(statusCode!)
                        return
                    default:
                        print("Le service est indisponible.")
                        print(statusCode!)
                        return
                    }
                } else if (response.error as? URLError) != nil {
                    print("Le service est indisponible.")
                    print(statusCode!)
                    return
                    
                } else if response.error == nil {
                    let json = JSON(response.result.value!)
                    print("=============================================")
                    print(json)
                    completion(json)
                }
            }
        
        return
    }

}
