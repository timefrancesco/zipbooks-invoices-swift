//
//  ViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        activityView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func login() {
       activityView.startAnimating()
        activityView.hidden = false
        
        APIservice.sharedInstance.login(usernameTextField.text!,password:passwordTextField.text!){ (result:Bool) in
            if result{
                APIservice.sharedInstance.generateHeaderAfterAuth()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainAuthorized")

            }
            else {
                self.activityView.stopAnimating()
                self.activityView.hidden = true
            }
        }
    }
    
    func setupViews(){
        let usernameBottomLine = UIView(frame: CGRectMake(usernameTextField.frame.origin.x, usernameTextField.frame.origin.y + usernameTextField.frame.height, usernameTextField.frame.size.width, 0.5))
        usernameBottomLine.backgroundColor = UIColor.whiteColor()
        usernameBottomLine.opaque = true
        
        
        let passwordBottomLine = UIView(frame: CGRectMake(passwordTextField.frame.origin.x, passwordTextField.frame.origin.y + passwordTextField.frame.height, passwordTextField.frame.size.width, 0.5))
        passwordBottomLine.backgroundColor = UIColor.whiteColor()
        passwordBottomLine.opaque = true
        
        view.addSubview(usernameBottomLine)
        view.addSubview(passwordBottomLine)
    }

    //delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (usernameTextField.isFirstResponder()){
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
            login()
        }
        
        return true
    }
}

