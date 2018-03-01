//
//  LoginViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/28/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    var golfer:[User] = []
    
    @IBAction func login(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            let loginPassword = password.trimmingCharacters(in: .whitespaces)
            if(email.isEmpty || loginPassword.isEmpty){
                print("email or password empty")
            }else{
                let login: Parameters = [
                    "email": "\(email)",
                    "password": "\(password)"
                ]
                
                let url = "http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Golfers/login"
                
                Alamofire.request(url, method: .post, parameters: login, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                    if response.result.value != nil, let value = response.result.value {
                        if(response.response?.statusCode == 200){
                            let result = value as! NSDictionary
                            Alamofire.request("http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Golfers/\(result["userId"]!)", method: .get).responseJSON(completionHandler: { response in
                                if response.response?.statusCode == 200{
                                    let username = response.result.value as! NSDictionary
                                    let id = result["id"] as! String
                                    let usern = username["username"] as! String
                                    let userId = result["userId"] as! Int
                                    self.golfer.append(User(id: id, username: usern, userId: userId))
                                }
                            }).resume()
                            self.performSegue(withIdentifier: "successful", sender: self)
                        }else{
                            let alert = UIAlertController(title: "Unable to Login", message: "Email or Password Invalid", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }).resume()
            }
        }
    }
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
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
            if let destination = segue.destination as? TabViewController{
                destination.golfer = self.golfer
            }
    }
}
