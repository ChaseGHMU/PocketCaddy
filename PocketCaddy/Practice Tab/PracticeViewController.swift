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
    
    @IBOutlet weak var typeLabel: UILabel!
    // cell reuse id (cells that scroll out of view can be reused)
    let defaults = UserDefaults.standard

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addClub: UIBarButtonItem! // megan -- button to allow user to add clubs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableview changes
        tableView.delegate = self
        tableView.dataSource = self
    
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        
    }
    
    func getClubs(){
        if let userId = defaults.string(forKey: "userId"), let tokenId = defaults.string(forKey: "id"){
            PocketCaddyData.getUserInfo(table: .clubs, tokenId: tokenId, userId: userId, completionHandler: { response in
                if let response = response{
                    for results in response {
                        if let obj = results as? NSDictionary{
                            let id = "\(obj["clubId"]!)"
                            let nickname = "\(obj["nickname"]!)"
                            let userId = "\(obj["userId"]!)"
                            let type = "\(obj["type"]!)"
                            var avgDist = "\(obj["avgDistance"]!)"
                            if avgDist == "<null>"{
                                avgDist = "0"
                            }
                            self.clubs.append(Clubs(id: id, type: type, name: nickname, distance: "\(avgDist) Yds", userId: userId))
                        }
                    }
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clubs = []
        getClubs()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addClubAlert(_ sender: UIBarButtonItem) {
       //code moved to addclubviewcontroller
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyLabel.text = ""
        tableView.isScrollEnabled = true
        return self.clubs.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath)
        
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.96, alpha:1.0)
        }
        
        else
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.93, alpha:1.0)
        }
        
        if let cell = cell as? PracticeClubViewCell {
            if(clubs[indexPath.row].type == "Driver")
            {
               cell.clubImage.image = UIImage(named: "DriverIcon")
            }
            
            else if(clubs[indexPath.row].type == "Iron")
            {
                cell.clubImage.image = UIImage(named: "IronIcon")
            }
            
            else if(clubs[indexPath.row].type == "Wedge")
            {
                cell.clubImage.image = UIImage(named: "IronIcon")
            }
             
            else if(clubs[indexPath.row].type == "Putter")
            {
                cell.clubImage.image = UIImage(named: "PutterIcon")
            }
            
            cell.clubTitle.text = clubs[indexPath.row].name
            cell.typeTitle.text = clubs[indexPath.row].type
            if cell.typeTitle.text == "<null>"{
                cell.typeTitle.text = "Driver"
            }
            
            cell.avgDistanceTitle.text = clubs[indexPath.row].distance
        }
        // set the text from the data model
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
      
        // Delete Club Code
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            let deleteAlert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                // remove the item from the data model
                if let tokenId = self.defaults.string(forKey: "id"){
                    PocketCaddyData.delete(table: .clubs, tokenId: tokenId, id: self.clubs[indexPath.row].id)
                    self.clubs.remove(at: indexPath.row)
                    // delete the table view row
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadData()
                }
                if self.clubs.count == 0{
                    self.emptyLabel.text = "You haven't added any clubs yet! Press the '+' at the top of the page to fill your bag."
                    self.emptyLabel.textAlignment = NSTextAlignment.center
                    self.tableView.backgroundView = self.emptyLabel
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                    //self.tableView.isScrollEnabled = false
                }
                
                
            })
            deleteAlert.addAction(yesAction)
            deleteAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(deleteAlert, animated: true, completion: nil)
        })
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? ClubCellViewController, let index = tableView.indexPathForSelectedRow {
            destination.club = clubs[index.row]
            
        }
    }
    
}
