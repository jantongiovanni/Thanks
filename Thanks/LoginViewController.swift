//
//  LoginViewController.swift
//  Thanks
//
//  Created by JoesMac on 7/23/18.
//  Copyright © 2018 JoesMac. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let alertController = UIAlertController(title: "Error", message: "Something went wrong when creating your profile. Please try again", preferredStyle: .alert)
    let accountAlreadyExists = UIAlertController(title: "Error", message: "An account with this username already exists. Please try another", preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default) { (action) in}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountAlreadyExists.addAction(okButton)
        alertController.addAction(okButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = userNameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) in
            if let error = error {
                print("User Login Failed: " + error.localizedDescription)
            } else {
                print("User Logged In Successfully")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            self.activityIndicator.startAnimating()
            self.view.addSubview(self.activityIndicator)
            if let error = error{
                self.activityIndicator.stopAnimating()
                print("Sign Up Error: " + error.localizedDescription)
                if (error as NSError).code == 202 {
                    UIApplication.shared.keyWindow?.rootViewController?.present(self.accountAlreadyExists, animated: true)
                } else {
                    UIApplication.shared.keyWindow?.rootViewController?.present(self.alertController, animated: true)
                }
            } else {
                print("User Registered Successfully")
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "registerSegue", sender: sender)
            }
        }
        
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSegue" {
            if let professionViewController = segue.destination as? ProfessionViewController {
                //do something
            }
        }
    }
    

}
