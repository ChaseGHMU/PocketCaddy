//
//  NotebookViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 4/23/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import Alamofire

class NotebookViewController: UIViewController {

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var notebookTextView: UITextView!
    var name: String?
    var comments = [Comments]()
    var courseId: String?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            courseName.text = name
        }
        if let userId = defaults.string(forKey: "userId"), let tokenId = defaults.string(forKey: "id"), let courseId = courseId{
            PocketCaddyData.getComments(tokenId: tokenId, userId: userId, courseId: courseId, completionHandler: {comment in
                self.comments = comment
                var commentString = ""
                for comment in self.comments{
                    commentString += comment.content
                }
                if commentString.isEmpty {
                    commentString = "You have no comments yet! \nEnter a note about the course"
                }
                self.notebookTextView.text = commentString
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateNotebook(_ sender: Any) {
        if let userId = defaults.string(forKey: "userId"), let tokenId = defaults.string(forKey: "id"), let courseId = courseId{
            let params: Parameters = [
                "userId": userId,
                "courseId": courseId,
                "content": self.notebookTextView.text
            ]
            PocketCaddyData.post(table: .golfers, newTable: .comments, userId: userId, tokenId: tokenId, parameters: params, login: false) { (dict, string, int) in
                print("String Updated")
            }
        }
        self.dismiss(animated: true, completion: nil)
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
