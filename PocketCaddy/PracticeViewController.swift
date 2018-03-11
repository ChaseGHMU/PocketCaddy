//
//  PracticeViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/26/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class PracticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Data model: These strings will be the data for the table view cells
    var clubs: [Clubs] = []
    var namePassed:String!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    let defaults = UserDefaults.standard

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addClub: UIBarButtonItem! // megan -- button to allow user to add clubs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PocketCaddyData.getUserInfo(table: .clubs, userId: "\(defaults.string(forKey: "userId")!)", completionHandler: { response in
            if let response = response{
                for results in response {
                    if let obj = results as? NSDictionary{
                        let id = "\(obj["clubId"]!)"
                        let nickname = "\(obj["nickname"]!)"
                        let userId = "\(obj["userId"]!)"
                        let avgDist = "\(obj["avgDistance"]!)"
                        self.clubs.append(Clubs(id: id, type: "nil", name: nickname, distance: avgDist, userId: userId))
                    }
                }
                self.tableView.reloadData()
            }
        })
        //tableview changes
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        if let image = UIImage(named: "iphone.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addClubAlert(_ sender: UIBarButtonItem) {
        // create the alert
        let alert = UIAlertController(title: "Add a Club", message: "Enter Name of Club:", preferredStyle: UIAlertControllerStyle.alert)

        // creating text field for club name
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Club"
        }
        // creates both add and cancel options for user        
        let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            
            if let textField = textField.text, let userId = self.defaults.string(forKey: "userId") {
                let parameters: Parameters = [
                    "nickname": "\(textField)",
                    "userId": "\(userId)"
                ]
                
                PocketCaddyData.post(table: .clubs, parameters: parameters, login: false, completionHandler: { (dict, string, response) in
                    if let dict = dict{
                        let id = "\(dict["clubId"]!)"
                        let nickname = "\(dict["nickname"]!)"
                        let userId = "\(dict["userId"]!)"
                        self.clubs.append(Clubs(id: id, type: "nil", name: nickname, distance: "0.0", userId: userId))
                    }
                    self.tableView.reloadData()
                })
            }
        })
        alert.addAction(submitAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show alert to user
        self.present(alert, animated: true, completion: nil)
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.clubs.count == 0{
            emptyLabel.text = "You haven't added any clubs yet! Press the '+' at the top of the page to fill your bag."
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            tableView.isScrollEnabled = false
            return 0
        }else{
            emptyLabel.text = ""
            tableView.isScrollEnabled = true
            return self.clubs.count
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        // set the text from the data model
        cell.textLabel?.text = self.clubs[indexPath.row].name
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue", sender: indexPath)
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.clubs.count == 0{
           return ""
        }else{
          return "List of Clubs"
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Edit Club Code -- Work in Progress
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            
            let alert = UIAlertController(title: "Edit a Club", message: "Enter New Name of Club:", preferredStyle: UIAlertControllerStyle.alert)
            
            // creating text field for club name
            alert.addTextField { (textField) in
                textField.placeholder = "Enter New Name"
            }
            
            let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
                //enter edit code here, just need to change club name to existing club
            })
            alert.addAction(submitAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        editAction.backgroundColor = UIColor.blue
        
        // Delete Club Code
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            let deleteAlert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                // remove the item from the data model
                PocketCaddyData.delete(table: .clubs, id: self.clubs[indexPath.row].id)
                self.clubs.remove(at: indexPath.row)
                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            })
            deleteAlert.addAction(yesAction)
            deleteAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(deleteAlert, animated: true, completion: nil)
        })
        deleteAction.backgroundColor = UIColor.red
        return [editAction, deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? ClubCellViewController, let index = tableView.indexPathForSelectedRow {
            destination.club = clubs[index.row]
        }
    }
    
}
