//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by John Berndt on 4/14/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
    }

    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
