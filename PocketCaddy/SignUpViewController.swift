//
//  SignUpViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/28/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitNewUser(_ sender: Any) {
        if let email = emailTextField.text, let usr = usernameTextField.text, let pass = passwordTextField.text{
            
            let obj: [String: String] = [
                "pasword": "\(pass)",
                "email": "\(email)",
                "username": "\(usr)"
            ]

            

            let jsonData = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
//            if let jsonData = jsonData{
//                let str = String(data: jsonData, encoding: .utf8)
//                if let str = str{
//                    print(str)
//                }
//            }
            
            print("\(jsonData! as NSData)")

//            let url = URL(string: "http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Golfers")!
//            var request = URLRequest(url: url)
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.httpMethod = "POST"
//            request.httpBody = jsonData
//            print(jsonData?.description)
//
//            let task = URLSession.shared.dataTask(with: request) {
//                (data, response, error) in
//                guard let data = data, error == nil else{
//                    print("Error: \(error!)")
//                    return
//                }
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                print("**********JSON**************** \n \(json!)")
//
//                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                    print("response = \(response!)")
//                }
//
//                if let responseString = String(data: data, encoding: .utf8){
//                    print("responseString = \(responseString)")
//                }
//            }
//            task.resume()
        }
        
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
