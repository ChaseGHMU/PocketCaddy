//
//  PlayScorecardTableViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/16/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PlayScorecardTableViewController: UITableViewController {
    var scores = [Scores]()
    var holes = [Holes]()
    var gameId: String?
    var courseId: String?
    var holeNum: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let gameId = gameId, let courseId = courseId{
            PocketCaddyData.getScores(gameId: gameId, completionHandler: { score in
                self.scores = score
            })
            PocketCaddyData.getHoles(courseId: courseId, completionHandler: {holes in
                self.holes = holes
                self.tableView.reloadData()
            })
        }
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scorecardCell", for: indexPath)
    
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.96, alpha:1.0)
        }
            
        else
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.93, alpha:1.0)
        }
        
        if let cell = cell as? PlayScorecardTableViewCell{
            cell.holeNumberTitle.text = "Hole \(holeNum[indexPath.row])"
            cell.parTitle.text = "Par \(holes[indexPath.row].par)"
            
            if scores[indexPath.row].scores == "0"{
                cell.scoresTitle.text = "Unplayed"
            }else{
                cell.scoresTitle.text = "\(scores[indexPath.row].scores)"
            }
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

}
