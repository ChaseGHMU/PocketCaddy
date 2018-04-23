//
//  DetailedGameViewController.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 4/18/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class DetailedGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var game:Games?
    var scores: [Scores] = []
    var holes: [Holes] = []
    let defaults = UserDefaults.standard
    var currentGame:String = ""
    var cName:String = ""
    

    @IBOutlet weak var finalScore: UILabel! //now gamedate
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var gameDate: UILabel! //now final score
    @IBOutlet weak var scoreTable: UITableView!
    var holeNum: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if let courseId = game?.courseId, let score = game?.finalScore, let gametime = game?.gameTime, let gameId = game?.gameId{
            getName(courseId: (game?.courseId)!)
            gameDate.text = "Final Score: \(score)"  //game?.gameTime
            finalScore.text = gametime //"Final Score:" + (game?.finalScore)!
            
            PocketCaddyData.getScores(gameId: gameId, completionHandler: {scores in
                self.scores = scores
            })
            PocketCaddyData.getHoles(courseId: courseId, completionHandler: {holes in
                self.holes = holes
                self.scoreTable.reloadData()
            })
            self.scoreTable.delegate = self
            self.scoreTable.dataSource = self
        }

        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holeCell", for: indexPath)
        
        if let cell = cell as? DetailedScoreTableViewCell {
            //cell.hole.text = getName(courseId: self.games[indexPath.row].courseId)
            if(indexPath.row % 2 == 0)
            {
                cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.96, alpha:1.0)
            }
                
            else
            {
                cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.93, alpha:1.0)
            }

            cell.hole.text = "Hole \(holeNum[indexPath.row])"
            cell.holeScore.text = self.scores[indexPath.row].scores
            cell.parCell.text = "Par \(self.holes[indexPath.row].par)"
            
            let score = Int(scores[indexPath.row].scores)
            let par = Int(holes[indexPath.row].par)
            if let score = score{
                if(score > par)
                {
                    cell.holeScore.textColor = UIColor.red
                }
                else if(score < par)
                {
                    cell.holeScore.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.39, alpha: 1.0)
                }
                else
                {
                    cell.holeScore.textColor = UIColor.black
                }
            }
        }
        return cell
        
    }

    func getScores(){
        if let userid = defaults.string(forKey: "userId"){
            PocketCaddyData.getUserInfo(table: .scores, userId: userid, completionHandler: { response in
                if let response = response{
                    for results in response {
                        if let obj = results as? NSDictionary{
                            
                            
                            let holeId = "\(obj["holeId"]!)"
                            let gameId = "\(obj["gameId"]!)"
                            
                            var scores = "\(obj["score"]!)"
                            if scores == "0"{
                                scores = "No Score"
                            }
                           
                            let holeId2 = Int(holeId)
                            if gameId == self.currentGame{
                                let myGame = gameId
                                self.scores.append(Scores(holeId: holeId2!, gameId: myGame, scores: scores))
                            }
                        }
                    }
                    self.scoreTable.reloadData()
                }
            })
        }
    }
    

    func getName(courseId: String){
        var usedName:String = ""

        if let userid = defaults.string(forKey: "userId"){
            PocketCaddyData.getUserInfo(table: .courses, userId: userid, completionHandler: { response in
                if let response = response{
                    for results in response {
                        if let obj = results as? NSDictionary{
                            let id = "\(obj["courseId"]!)"
                            let name = "\(obj["courseName"]!)"
                            if courseId == String(id){
                                usedName = name
                                 self.courseName.text = usedName
                            }
                        }
                    }
                    
                }
            })}}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

        }
