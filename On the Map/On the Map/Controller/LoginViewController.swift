//
//  LoginViewController.swift
//  On the Map
//
//  Created by John Berndt on 2/10/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        print("loginTapped")
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        UIApplication.shared.open(UdacityClient.Endpoints.signup.url, options: [:], completionHandler: nil)
    }
}

