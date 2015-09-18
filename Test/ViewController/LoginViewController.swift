//
//  LoginViewController.swift
//  Test
//
//  Created by Mingming Wang on 9/12/15.
//  Copyright (c) 2015 Mingming Wang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, JsonReceiverDelegate {
    @IBOutlet var usernameTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    
    var alertView:UIAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Login"
        
        WebFetcher.sharedInstance.delegate = self
        
        self.usernameTextField.text = "test@nullindustries.co"
        self.passwordTextField.text = "123"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func login() {
        var username: NSString = usernameTextField.text
        var password: NSString = passwordTextField.text
        
        self.showLoadingDialog()
        
        WebFetcher.sharedInstance.login(username, password: password)
    }
    
    func receiveJson(jsonDictionary:NSDictionary) {
        println("The result is: " + jsonDictionary.description)
        
        self.hideLoadingDialog()
        
        dispatch_after((1 * NSEC_PER_SEC), dispatch_get_main_queue(), {
            let orderVC = self.storyboard?.instantiateViewControllerWithIdentifier("orderVC") as OrderListViewController
            
            self.navigationController?.pushViewController(orderVC, animated: true)
        })
        
    }
    
    func showLoadingDialog() {
        alertView = UIAlertView()
        alertView.title = "Login..."
        alertView.show()
    }
    
    func hideLoadingDialog() {
        alertView.dismissWithClickedButtonIndex(0, animated: true)
    }
    
}
