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
            
            let obj: Parameters = [
                "password": "\(pass)",
                "email": "\(email)",
                "username": "\(usr)"
            ]
            
            let url = "http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Golfers"
            
            Alamofire.request(url, method: .post, parameters: obj, encoding:JSONEncoding.default).responseJSON(completionHandler: { response in
                if response.result.value != nil {
                    let statusCode = response.response?.statusCode
                    if(statusCode != 200){
                        print("error")
                    }else{
                        let alert = UIAlertController(title: "Account Succesfully Created", message: "Please confirm your email address to login", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true)
                    }
                    
                }
            })
        }
        
    }
    

//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
    
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//    }

}
