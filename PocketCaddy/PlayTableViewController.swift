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
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
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
        return course?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.96, alpha:1.0)
        }
            
        else
        {
            cell.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.93, alpha:1.0)
        }
        
        if let cell = cell as? PlaySearchTableViewCell, let course = course?[indexPath.row] {
            cell.courseLabel.text = course.name
            cell.addressLabel.text = course.address1
            
        }
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PlayResultViewController, let index = tableView.indexPathForSelectedRow,
            let course = course{
            destination.course = course[index.row]
        }
        search.dismiss(animated: true, completion: {})
    }

}
