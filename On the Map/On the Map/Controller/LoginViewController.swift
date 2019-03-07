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
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        print("loginTapped")

        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse)
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        UIApplication.shared.open(UdacityClient.Endpoints.signup.url, options: [:], completionHandler: nil)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            //activityIndicator.startAnimating()
        } else {
            //activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            print("Happy")
            UdacityClient.logout(completion: handleLogoutResponse)
        } else {
            let message = error?.localizedDescription ?? ""
            print("\(message)");
            print("Sad")
        }
    }
    
    func handleLogoutResponse() {
        print("Logged Out")
    }
}

