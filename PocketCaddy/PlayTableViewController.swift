//
//  PlayTableViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/2/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PlayTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var course: [Course]?
    func updateSearchResults(for searchController: UISearchController) {
        if let text = search.searchBar.text {
            PocketCaddyData.search(searchText: text, completionHandler: { (course) in
                if let course = course{
                    self.course = course
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    var search: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 98
        self.definesPresentationContext = true
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.sizeToFit()
        search.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = search.searchBar
        search.searchBar.showsCancelButton = false
        
//        let editButton = self.editButtonItem
//        self.navigationItem.rightBarButtonItem = editButton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        search.dismiss(animated: true, completion: {})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return course?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        if let cell = cell as? PlaySearchTableViewCell, let course = course?[indexPath.row] {
            cell.courseLabel.text = course.name
            cell.addressLabel.text = course.address1
            
        }
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        search.dismiss(animated: true, completion: {})
    }

}
