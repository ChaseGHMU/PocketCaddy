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

    @IBAction func openMapsWithDirections(_ sender: Any) {
        if let course = course{
            var address = course.address1
            let state = course.state
            var city = course.city
            address = address.replacingOccurrences(of: " ", with: "+")
            city = city.replacingOccurrences(of: " ", with: "+")
            city.append(",+\(state)")
            address.append(",+\(city)")
            var map = "http://maps.apple.com/?daddr="
            map.append(address)
            let mapURL = URL(string: map)
            if let mapURL = mapURL{
                UIApplication.shared.open(mapURL, options: [:], completionHandler: nil)
            }
            print(address)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PlayMapViewController, let course = course{
                destination.courseId = course.id
                destination.courseName = course.name
        }
    }


}
