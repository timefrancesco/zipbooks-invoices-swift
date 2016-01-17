//
//  ViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login() {
       
        APIservice.sharedInstance.login(usernameTextField.text!,password:passwordTextField.text!){ (result:Bool) in
            if result{
                APIservice.sharedInstance.generateHeaderAfterAuth()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainAuthorized")

            }
        }
    }

}

