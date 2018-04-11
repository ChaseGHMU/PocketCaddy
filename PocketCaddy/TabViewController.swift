//
//  TabViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/1/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    
    var golfer:[User] = []
    let defaults = UserDefaults.standard
    var logged:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        logged = defaults.bool(forKey: "isLoggedIn")
        if let logged = logged{
            if(!logged){
                self.performSegue(withIdentifier: "notLogged", sender: self)
            }
        }
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
