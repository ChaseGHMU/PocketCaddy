//
//  ClubCellViewController.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 3/4/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class ClubCellViewController: UIViewController {

    @IBOutlet weak var clubName: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        clubName.text = name
        
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
