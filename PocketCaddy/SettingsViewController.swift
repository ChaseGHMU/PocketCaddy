//
//  SettingsViewController.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 3/1/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBAction func logout(_ sender: Any) {
        defaults.set(nil, forKey: "id")
        defaults.set(nil, forKey: "username")
        defaults.set(nil, forKey: "userId")
        defaults.set(nil, forKey: "created")
        defaults.set(false, forKey: "isLoggedIn")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        
        if let image = UIImage(named: "iphone.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
