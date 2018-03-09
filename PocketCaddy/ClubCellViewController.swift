//
//  ClubCellViewController.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 3/4/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class ClubCellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var avgDistance: UILabel!
    @IBOutlet weak var numSwings: UILabel!
    var name: String?
    var distances: [Int] = []
    
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addSwing(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Swing", message: "How far did you hit the ball?", preferredStyle: UIAlertControllerStyle.alert)
        
        // creating text field for swing distance
        
//        alert.addTextField { (textField) in
//            textField.placeholder = "Enter Distance"
//            textField.keyboardType = .decimalPad
//        }
        
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
        })
        
        
        // adds functionality to allow user to input a distance for a new swing
        let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            
            let textField = alert.textFields![0]
            print(textField.text!)
            
        
            
            let textfieldInt: Int? = Int(textField.text!)
            if let textfieldInt = textfieldInt {
                print(textfieldInt)
            }
            if (textfieldInt == nil){
               print("Not an integer")  // if user enters a non-integer value, the error is printed to console and it is not added to the array...will work on alerting user of issue
            }
            else{
                self.distances.append(textfieldInt!)
            }
            
            
            self.tableView.reloadData() //reloads data so new club is displayed
            
            let count = String(self.distances.count)
            self.numSwings.text = count
            
            let sumArray = self.distances.reduce(0,+)
            if(self.distances.count == 0){
                self.avgDistance.text = "0"
            }
            else{
                let average = sumArray / self.distances.count
                let strAvg = String(average)
                self.avgDistance.text = strAvg
            }
            print("average is: " + self.avgDistance.text!)
            print("number is: " + self.numSwings.text!)
        })
        alert.addAction(submitAction)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show alert to user
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            print(name)
        }
        clubName.text = name
        
        
        //tableview setup
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.distances.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        //cell.textLabel?.text = self.distances[indexPath.row]
        
        let stringInt = String(self.distances[indexPath.row])
        cell.textLabel?.text = stringInt
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        print(distances[indexPath.row])
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
