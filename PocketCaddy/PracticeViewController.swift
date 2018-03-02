//
//  PracticeViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/26/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {

    @IBAction func pleaseWork(_ sender: Any) {
        PocketCaddyData.get(table: .courses, id: "1", exists: false) { (dict, success, status) in
            if let dict = dict, success == "Success", status == 200{
                let name = "\(dict["courseName"]!)"
                let address = "\(dict["addressLine1"]!)"
                let zip = "\(dict["zipCode"]!)"
                
                self.name?.text = name
                self.address?.text = address
                self.zipcode?.text = zip
            }
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
