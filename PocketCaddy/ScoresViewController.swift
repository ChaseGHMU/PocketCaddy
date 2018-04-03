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

    @IBOutlet weak var settingButton: UIBarButtonItem!
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
    }
    
    //added 3/19
    func getGames(){
        PocketCaddyData.getUserInfo(table: .games, userId: "\(defaults.string(forKey: "userId")!)", completionHandler: { response in
            if let response = response{
                for results in response {
                    if let obj = results as? NSDictionary{
                        let gameId = "\(obj["gameId"]!)"
                        let courseId = "\(obj["courseId"]!)"
                        let userId = "\(obj["userId"]!)"
                        let gameTime = "\(obj["gameTime"]!)"
                        let finalScore = "\(obj["finalScore"]!)"
                        self.games.append(Games(gameId: gameId, courseId: courseId, userId: userId, gameTime: gameTime, finalScore: finalScore))
                    }
                }
                self.scoresTableView.reloadData()
            }
        })
        print(games)
        print(games.count)
    }
    
    //added 3/19
    override func viewDidAppear(_ animated: Bool) {
        games = []
        getGames()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
            cell.courseName.text = "Augusta National"
            cell.courseName.textColor = UIColor(red: 0.00, green:0.56, blue:0.32, alpha:1.0)
            cell.scoreShot.text = "+2"
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
            cell.datePlayed.text = "April 15, 2017"
        }
        return cell

//added 3/19
//        let cell = scoresTableView.dequeueReusableCell(withIdentifier: "scoresCell", for: indexPath)
//        if let cell = cell as? ScoresTableViewCell {
//           // cell.courseName.text = games[indexPath.row].courseId
////            cell.scoreShot.text = games[indexPath.row].finalScore
////            cell.datePlayed.text = games[indexPath.row].gameTime
//        }
//        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "PREVIOUS 5 GAMES"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
