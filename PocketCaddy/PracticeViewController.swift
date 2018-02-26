//
//  PracticeViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/26/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

struct Courses: Codable{
    let id: Int?
    let name: String?
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let zipCode: Int?
    
    private enum CodingKeys : String, CodingKey {
        case id = "courseID"
        case name = "courseName"
        case address1 = "addressLine1"
        case address2 = "addressLine2"
        case city
        case state
        case zipCode
    }
}

class PracticeViewController: UIViewController {

    @IBAction func pleaseWork(_ sender: Any) {
        let urlString = "http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Courses/1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let courseData = try decoder.decode(Courses.self , from: data)
                
                if let name = courseData.name{
                    self.name.text = name
                }
                
                if let zipcode = courseData.zipCode{
                    self.zipcode.text = String(zipcode)
                }
                
                if let address = courseData.address1{
                    self.address.text = address
                }
                
            } catch let err{
                print("Err", err)
            }
            }.resume()
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
