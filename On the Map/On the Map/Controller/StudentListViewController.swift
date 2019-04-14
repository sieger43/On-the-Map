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
        
        return StudentInformationModel.locations.count
    }
    
    /**
     * Cell For Row At Index Path
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = StudentInformationModel.locations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListTableViewCell")
        
        if let label = cell!.textLabel,
            let detail_label = cell!.detailTextLabel,
            let label_image = cell!.imageView {
            
            if let first_name = location.firstName,
                let last_name = location.lastName {
            
                label.text = first_name + " " + last_name
                detail_label.text = location.mediaURL;
                label_image.image = UIImage(named: "icon_pin")
            }
        }

        return cell!
    }

    func showAlert() {
        let alert = UIAlertController(title: "", message: "Invalid Link", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    /**
     * didSelectRowAtIndexPath
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let cell = tableView.cellForRow(at: indexPath as IndexPath)

        if let studentInfoCell = cell, let urlStringLabel = studentInfoCell.detailTextLabel,
            let urlstring = urlStringLabel.text, let url = URL(string: urlstring) {
                    UIApplication.shared.open(url, options: [:]) { success in
                        if !success {
                            self.showAlert()
                        }
                    }
        } else {
            showAlert()
        }
    }
}
