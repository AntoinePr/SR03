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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadPurchases() {
        self.getPurchases() { (json) -> () in
            print(json)
            print("\n----------------------------\n")
            for i in 0...(json.count-1) {
                print(json.count)
                self.purchases.append(Purchase(
                    title: json[i]["nom"].string!,
                    description: json[i]["description"].string!
                ))
                print(json[i]["nom"].string!)
            }
            self.tableView.reloadData()
        }
    }
    
    func getPurchases(completion: @escaping (_ json: JSON)->Void)
    {
        let headers: HTTPHeaders = ["AUTHORIZATION": "Token 7qj6nnih59mabub1qaloogcov0"]
        
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
                    completion(json)
                }
            }
        
        return
    }

}
