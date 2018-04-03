//
//  PlayResultViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/3/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PlayResultViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var startingHoleTextfield: UITextField!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var course:Course?
    var pickedHole = 0
    var holes = ["One (1)", "Two (2)", "Three (3)", "Four (4)", "Five (5)", "Six (6)",
                 "Seven (7)", "Eight (8)", "Nine (9)", "Ten (10)", "Eleven (11)", "Twelve (12)",
                 "Thirteen (13)", "Fourteen (14)", "Fifteen (15)", "Sixteen (16)", "Seventeen (17)", "Eighteen (18)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        if let course = course{
            courseLabel.text = course.name
            addressLabel.text = "\(course.address1), \(course.city), \(course.state) \(course.zipCode)"
        }
        startingHoleTextfield.text = holes[0]
        startingHoleTextfield.inputView = pickerView
    
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return holes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return holes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        startingHoleTextfield.text = holes[row]
        pickedHole = row
        startingHoleTextfield.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PlayMapViewController, let course = course{
                destination.courseId = course.id
                destination.courseName = course.name
                destination.hole = pickedHole
        }
    }


}
