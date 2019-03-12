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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
        setLoggingIn(false)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(true)

        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse)
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        UIApplication.shared.open(UdacityClient.Endpoints.signup.url, options: [:], completionHandler: nil)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        
        setLoggingIn(false)
        
        if success {
            print("Happy")
            performSegue(withIdentifier: "completeLogin", sender: nil)
//            UdacityClient.logout(completion: handleLogoutResponse)
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

