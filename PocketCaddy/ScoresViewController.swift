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
    
    var games: [Games] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
        if let image = UIImage(named: "iphone.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
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
        if let cell = cell as? ScoresTableViewCell {
            cell.courseName.text = "Augusta National"
            cell.scoreShot.text = "+2"
            cell.datePlayed.text = "April 15, 2017"
        }
        return cell

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
