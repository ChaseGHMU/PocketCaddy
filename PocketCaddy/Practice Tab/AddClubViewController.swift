//
//  AddClubViewController.swift
//  
//
//  Created by Megan Cochran on 4/13/18.
//

import UIKit

class AddClubViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
  

    @IBOutlet weak var clubPicker: UIPickerView!
    let clubTypes = ["Driver", "Putter", "Wedge", "Iron"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubPicker.delegate = self
        clubPicker.dataSource = self
        

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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
