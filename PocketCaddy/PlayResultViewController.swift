//
//  PlayResultViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/3/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PlayResultViewController: UIViewController {

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var course:Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let course = course{
            courseLabel.text = course.name
            addressLabel.text = "\(course.address1), \(course.city), \(course.state) \(course.zipCode)"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PlayMapViewController, let course = course{
                destination.courseId = course.id
        }
    }


}
