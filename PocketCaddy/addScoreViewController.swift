//
//  addScoreViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/16/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class addScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var numPuttsPicker: UIPickerView!
    @IBOutlet weak var shotsTakenPicker: UIPickerView!
    
    var strokes = [1, 2, 3, 4 ,5 ,6 ,7 ,8, 9, 10, 11, 12]
    var putts = [1, 2, 3, 4 ,5]
    var strokesTitle = 1
    var puttsTitle = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numPuttsPicker.dataSource = self
        numPuttsPicker.delegate = self
        shotsTakenPicker.dataSource = self
        shotsTakenPicker.delegate = self
        print("loaded")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        print(puttsTitle)
        print(strokesTitle)
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
