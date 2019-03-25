//
//  StudentListViewController.swift
//  On the Map
//
//  Created by John Berndt on 3/18/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit

class StudentListViewController: UITableViewController {

    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    /**
     * Number of Rows
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return StudentModel.locations.count
    }
    
    /**
     * Cell For Row At Index Path
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = StudentModel.locations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListTableViewCell")
        
        
        
        cell!.textLabel?.text = location.firstName! + " " + location.lastName!
        cell!.detailTextLabel?.text = location.mediaURL;
        cell!.imageView?.image = UIImage(named: "icon_pin")
        
        return cell!
    }
    
}
