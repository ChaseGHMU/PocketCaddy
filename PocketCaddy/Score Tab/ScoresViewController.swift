//
//  ScoresViewController.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 3/1/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class ScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scoresTableView: UITableView!

    //added 3/19
    var games: [Games] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
        if let image = UIImage(named: "magnolia-golf-course.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        // Do any additional setup after loading the view.
        games=[]
        getGames()
    }
    
    //added 3/19
    func getGames(){
        if let userid = defaults.string(forKey: "userId"), let tokenId = defaults.string(forKey: "id"){
            PocketCaddyData.getUserInfo(table: .games, tokenId: tokenId, userId: userid, completionHandler: { response in
                if let response = response{
                    for results in response {
                        if let obj = results as? NSDictionary{
                            let gameId = "\(obj["gameId"]!)"
                            let courseId = "\(obj["courseId"]!)"
                            let userId = "\(obj["userId"]!)"
                            var gameTime = "\(obj["gameTime"]!)"
                            //below if stame removes extra date information to only show year/month/date
                            if let tRange = gameTime.range(of: "T") {
                                gameTime.removeSubrange(tRange.lowerBound..<gameTime.endIndex)
                            }
                           
                            var finalScore = "\(obj["finalScore"]!)"
                            let scoreToNum:Int? = Int(finalScore)
                            if finalScore == "<null>"{
                                finalScore = "Unfinished"
                            }else{
                                if let scoreToNum = scoreToNum, scoreToNum > 0{
                                    finalScore = "+\(scoreToNum)"
                                }else if scoreToNum == 0{
                                    finalScore = "E"
                                }
                            }
                            self.games.append(Games(gameId: gameId, courseId: courseId, userId: userId, gameTime: gameTime, finalScore: finalScore))
                        }
                    }
                    self.scoresTableView.reloadData()
                }
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoresCell", for: indexPath)
        
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.96, alpha:1.0)
        }
            
        else
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.93, alpha:1.0)
        }
        if let cell = cell as? ScoresTableViewCell {
            getName(courseId: self.games[indexPath.row].courseId, cell: cell)
            cell.courseName.textColor = UIColor(red: 0.00, green:0.56, blue:0.32, alpha:1.0)
            cell.scoreShot.text = self.games[indexPath.row].finalScore
            let score = cell.scoreShot.text![(cell.scoreShot.text?.startIndex)!]
            if(score == "-")
            {
                cell.scoreShot.textColor = UIColor.red
            }
            else if(score == "+")
            {
                cell.scoreShot.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.39, alpha: 1.0)
            }
            else
            {
                cell.scoreShot.textColor = UIColor.black
            }
            cell.datePlayed.text = self.games[indexPath.row].gameTime
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "PREVIOUS GAMES"
    }
    
    func getName(courseId: String, cell: ScoresTableViewCell){
        var usedName:String = ""
        
        if let userid = defaults.string(forKey: "userId"), let tokenId = defaults.string(forKey: "id"){
            PocketCaddyData.getUserInfo(table: .courses, tokenId: nil, userId: userid, completionHandler: { response in
                if let response = response{
                    for results in response {
                        if let obj = results as? NSDictionary{
                            let id = "\(obj["courseId"]!)"
                            let name = "\(obj["courseName"]!)"
                            if courseId == id{
                                usedName = name
                               cell.courseName.text = usedName
                            }
                        }
                    }
                    
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? DetailedGameViewController, let index = scoresTableView.indexPathForSelectedRow {
           // destination.club = clubs[index.row]
            destination.game = games[index.row]
        }
        //logoutSegue
        if let destination = segue.destination as? TabViewController {
            defaults.set(nil, forKey: "id")
            defaults.set(nil, forKey: "username")
            defaults.set(nil, forKey: "userId")
            defaults.set(nil, forKey: "created")
            defaults.set(false, forKey: "isLoggedIn")
            print("Logging out")
        }
    }
}
