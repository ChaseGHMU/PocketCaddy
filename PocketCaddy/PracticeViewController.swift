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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addClub: UIBarButtonItem! // megan -- button to allow user to add clubs
    
    @IBAction func addClubAlert(_ sender: UIBarButtonItem) {
        // create the alert
        let alert = UIAlertController(title: "Add a Club", message: "Enter Name of Club:", preferredStyle: UIAlertControllerStyle.alert)

        // creating text field for club name
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Club"
        }
        // creates both add and cancel options for user
       // alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: nil))
        
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
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Clubs?filter[where][userId][like]=\(defaults.string(forKey: "userId")!)"
        Alamofire.request(url,method: .get).responseData { (response) in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any]{
                    for results in array{
                        if let obj = results as? NSDictionary{
                            let id = "\(obj["clubId"]!)"
                            let nickname = "\(obj["nickname"]!)"
                            let userId = "\(obj["userId"]!)"
                            self.clubs.append(Clubs(id: id, type: "nil", name: nickname, distance: "0", userId: userId))
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
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
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clubs.count
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
        return "List of Clubs"
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? ClubCellViewController, let index = tableView.indexPathForSelectedRow {
            destination.name = clubs[index.row].name
        }
        //search.dismiss(animated: true, completion: {})
    }
  

    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            PocketCaddyData.delete(table: .clubs, id: clubs[indexPath.row].id)
            clubs.remove(at: indexPath.row)
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
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
