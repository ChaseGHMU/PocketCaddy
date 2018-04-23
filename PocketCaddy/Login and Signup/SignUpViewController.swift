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
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "iphone.jpg"){
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //source: https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    //checks if password is at least 8 characters
    func validatePassword(enteredPass:String) -> Bool {
        if enteredPass.count >= 8{
            return true
        } else {
            return false
        }
    }
    
    
    
    @IBAction func submitNewUser(_ sender: Any) {
        
        //validates both email and password, displays alerts to prompt user how to correct mistakes
        if validateEmail(enteredEmail: emailTextField.text!) == false && validatePassword(enteredPass: passwordTextField.text!) == false {
            let alert = UIAlertController(title: "Invalid Email & Password", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        } else if validateEmail(enteredEmail: emailTextField.text!) == false {
            let alert = UIAlertController(title: "Invalid Email", message: "Please try entering your email again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        } else if validatePassword(enteredPass: passwordTextField.text!) == false {
            let alert = UIAlertController(title: "Invalid Password", message: "Please try a password of at least 8 characters.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }
        
        
        if let email = emailTextField.text, let usr = usernameTextField.text, let pass = passwordTextField.text{
            let obj: Parameters = [
                "password": "\(pass)",
                "email": "\(email)",
                "username": "\(usr)"
            ]
            PocketCaddyData.post(table: .golfers, newTable: nil, userId: nil, tokenId: nil, parameters: obj, login: false, completionHandler: { (dict, success, code) in
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
