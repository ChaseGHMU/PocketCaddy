//
//  AddClubViewController.swift
//  
//
//  Created by Megan Cochran on 4/13/18.
//

import UIKit
import Alamofire

class AddClubViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
  

    @IBOutlet weak var clubName: UITextField!
    @IBOutlet weak var addClub: UIButton!
    @IBOutlet weak var clubPicker: UIPickerView!
    let clubTypes = ["Driver", "Putter", "Wedge", "Iron"]
    var pickedType = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubPicker.delegate = self
        clubPicker.dataSource = self
        self.title = "Add Club"

        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clubTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clubTypes[row]
    }
    
 

    
    @IBAction func addClub(_ sender: Any) {
        let selectedValue = clubTypes[clubPicker.selectedRow(inComponent: 0)]
        if let textField = clubName.text, let userId = self.defaults.string(forKey: "userId"), let tokenId = defaults.string(forKey: "id"){
            print("TOKEN: \(tokenId)")
            let parameters: Parameters = [
                "nickname": "\(textField)",
                "userId": "\(userId)",
                "type": "\(selectedValue)"
                
            ]
        
            PocketCaddyData.post(table: .golfers, newTable: .clubs, userId: userId, tokenId: tokenId, parameters: parameters, login: false, completionHandler: { (dict, string, response) in
        })
    }
        navigationController?.popViewController(animated: true)
    }
}
