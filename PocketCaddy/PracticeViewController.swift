//
//  PracticeViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/26/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Data model: These strings will be the data for the table view cells
    var clubs: [String] = ["club1", "club2", "club3", "club4", "club5"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func pleaseWork(_ sender: Any) {
        PocketCaddyData.get(table: .courses, id: "1", exists: false) { (dict, success, status) in
            if let dict = dict, success == "Success", status == 200{
                let name = "\(dict["courseName"]!)"
                let address = "\(dict["addressLine1"]!)"
                let zip = "\(dict["zipCode"]!)"
                
                self.name?.text = name
                self.address?.text = address
                self.zipcode?.text = zip
            }
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    //megan's changes
    @IBOutlet weak var addClub: UIBarButtonItem! // megan -- button to allow user to add clubs
    
    @IBAction func addClubAlert(_ sender: UIBarButtonItem) {
        // create the alert
        let alert = UIAlertController(title: "Add a Club", message: "Enter Name of Club:", preferredStyle: UIAlertControllerStyle.alert)

        // creating text field for club name
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Club"
        }
        // creates both add and cancel options for user
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show alert to user
        self.present(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableview changes
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clubs.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.clubs[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            clubs.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
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
