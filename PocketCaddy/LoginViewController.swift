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
    
    @IBOutlet weak var buttonDesign: UIButton!
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
                
                PocketCaddyData.post(table: .golfers, parameters: login, login: true, completionHandler: { (dict, success, code) in
                    if(success == "Success"), let dict = dict{
                        print(dict)
                        let dictID = "\(dict["userId"]!)"
                        print(dictID)
                        PocketCaddyData.get(table: .golfers, id: dictID, exists: false, completionHandler: { (result, success, code) in
                            if(success == "Success"), let result = result{
                                let id = "\(result["id"]!)"
                                let user = "\(result["username"]!)"
                                let userId = "\(dict["userId"]!)"
                                self.golfer.append(User(id: id, username: user, userId: userId))
                                self.performSegue(withIdentifier: "successful", sender: self)
                            }
                        })
                    }else{
                        let alert = UIAlertController(title: "Unable to Login", message: "Email or Password Invalid", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                            self.present(alert, animated: true, completion: nil)
                        }
                })
            }
        }
    }
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "iphone.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        buttonDesign.frame = CGRect(x: 100.0, y: 60.0, width: 120.0, height: 60.0)
        buttonDesign.backgroundColor = UIColor(hue: 0.5667, saturation: 1, brightness: 1, alpha: 1.0)
        buttonDesign.titleLabel?.textColor = UIColor.white
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
