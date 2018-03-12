//
//  SignUpViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/28/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var segue:String = "false"
    let user:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "iphone.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
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
            let obj: Parameters = [
                "password": "\(pass)",
                "email": "\(email)",
                "username": "\(usr)"
            ]
            PocketCaddyData.post(table: .golfers, parameters: obj, login: false, completionHandler: { (dict, success, code) in
                if code == 200{
                    let alert = UIAlertController(title: "Account Succesfully Created", message: "Please confirm your email address to login", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }else {
                    let alert = UIAlertController(title: "Error", message: "Email or Password already exists", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            })
        }
    }

}
