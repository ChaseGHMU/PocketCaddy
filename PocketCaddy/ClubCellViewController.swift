//
//  ClubCellViewController.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 3/4/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class ClubCellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var avgDistance: UILabel!
    @IBOutlet weak var numSwings: UILabel!
    var sum: Int = 0
    var club:Clubs?
    var swings: [Swings] = []
    let now = Date()
    let datetime = DateFormatter()
    let defaults = UserDefaults.standard
    
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datetime.dateFormat = "yyyy-MM-dd"
        datetime.timeZone = TimeZone(secondsFromGMT: 0)
        if let club = club{
            clubName.text = club.name
            PocketCaddyData.getSwings(table: .swings, clubId: club.id, completionHandler: { response in
                if let response = response{
                    self.swings = response
                }
                self.numSwings.text = "\(self.swings.count)"
                self.getAvgSwing()
                self.tableView.reloadData()
            })
        }
        
        //tableview setup
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        if let image = UIImage(named: "smallCourse.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addSwing(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Swing", message: "How far did you hit the ball?", preferredStyle: UIAlertControllerStyle.alert)
        
        // creating text field for swing distance
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
        })
        
        
        // adds functionality to allow user to input a distance for a new swing
        let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text

            let textField = alert.textFields![0]
//            print(textField.text!)
            let textfieldInt: Int? = Int(textField.text!)
            
            //Error Checking for values over 300
            if (textfieldInt! >= 300){
                let alert2 = UIAlertController(title: "Are you sure", message: "Is " + textField.text! + " what you really meant?", preferredStyle: UIAlertControllerStyle.alert)
                let submitAction2 = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                    self.postData(distance: textfieldInt!)
                })
                alert2.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
                alert2.addAction(submitAction2)
                
                self.present(alert2, animated: true, completion: nil)
            } else {
                self.postData(distance: textfieldInt!)
            }
        })
        alert.addAction(submitAction)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show alert to user
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func postData(distance: Int) {
        
        let parameters: Parameters = [
            "distance": "\(distance)",
            "clubId": "\(self.club!.id)"
        ]
        PocketCaddyData.post(table: .swings, parameters: parameters, login: false, completionHandler: { (dict, string, response) in
            if let dict = dict{
                let swingId = "\(dict["swingId"]!)"
                let distance = dict["distance"]! as! Int
                let clubId = "\(dict["clubId"]!)"
                self.swings.append(Swings(swingId: swingId, distance: distance, clubId: clubId, date: nil))
            }
            self.getAvgSwing()
            self.tableView.reloadData()
        })
    }
    
    func getAvgSwing() {
        let count = String(self.swings.count)
        
        for swing in self.swings {
            self.sum += swing.distance
        }
        var average:Int = 0
        if self.swings.count == 0{
            average = 0
        }else{
            average = self.sum / self.swings.count
        }
        self.avgDistance.text = "\(average)"
        self.numSwings.text = count
    }
    
    //tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.swings.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        let stringInt = String(self.swings[indexPath.row].distance)
        cell.textLabel?.text = stringInt + " yards"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Previous Swings"
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Delete Swing Code
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            
            let deleteAlert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            // once swings are persistent, the changes to delete will go in yesAction below
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                self.swings.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            })
            deleteAlert.addAction(yesAction)
            deleteAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(deleteAlert, animated: true, completion: nil)
            
        })
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }

}
