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
        let urlString = "http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Courses/1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard error == nil, let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let courseData = try decoder.decode(Course.self , from: data)
                
                DispatchQueue.main.sync {
                    self.name?.text = courseData.name
                    self.address?.text = courseData.address1
                    self.zipcode?.text = "\(courseData.zipCode)"
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
