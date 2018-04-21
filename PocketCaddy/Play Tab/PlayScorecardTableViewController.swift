//
//  PlayScorecardTableViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/16/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class PlayScorecardTableViewController: UITableViewController {
    var scores = [Scores]()
    var holes = [Holes]()
    var gameId: String?
    var courseId: String?
    let defaults = UserDefaults.standard
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
            
            let strokes = Int(scores[indexPath.row].scores)
            
            if(strokes! < (holes[indexPath.row].par -  2) && strokes! > 0)
            {
                cell.scoresTitle.textColor = UIColor.red
            }
            else if(strokes! > (holes[indexPath.row].par -  2))
            {
                cell.scoresTitle.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.39, alpha: 1.0)
            }
            else
            {
                cell.scoresTitle.textColor = UIColor.black
            }
        }

        return cell
    }

    @IBAction func finishRound(_ sender: Any) {
        if let gameId = gameId, let courseId = courseId, let userId = defaults.string(forKey: "userId"){
            var totalScore = 0;
            var totalPar = 0;
            
            for i in 0...17 {
                let x: Int? = Int(scores[i].scores)
                if let x = x, x != 0{
                    totalScore += x
                    totalPar += holes[i].par
                }
            }
            
            let finalScore = totalScore - totalPar
            
            let params: Parameters = [
                "gameId": gameId,
                "courseId": courseId,
                "userId": userId,
                "finalScore": finalScore
            ]

            PocketCaddyData.updateGame(parameters: params)
        }
    }
}
