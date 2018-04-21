//
//  addScoreViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/16/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class addScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var numPuttsPicker: UIPickerView!
    @IBOutlet weak var shotsTakenPicker: UIPickerView!
    
    var strokes = [1, 2, 3, 4 ,5 ,6 ,7 ,8, 9, 10, 11, 12]
    var putts = [1, 2, 3, 4 ,5]
    var strokesTitle = 1
    var puttsTitle = 1
    var holeId: String?
    var gameId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numPuttsPicker.dataSource = self
        numPuttsPicker.delegate = self
        shotsTakenPicker.dataSource = self
        shotsTakenPicker.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        if let gameId = gameId, let holeId = holeId{
            let parameters: Parameters = [
                "gameId": gameId,
                "holeId": holeId,
                "score": strokesTitle
            ]
            PocketCaddyData.update(gameId: gameId, holeId: holeId, parameters: parameters, completionHandler: { (bool) in
            })
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            strokesTitle = strokes[row]
        }else{
            puttsTitle = putts[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return strokes.count
        }
        return putts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return "\(strokes[row])"
        }
        return "\(putts[row])"
    }
}
