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
        activityView.isHidden = true
        
        let str = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        usernameTextField.attributedPlaceholder = str
        
        let str2 = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        passwordTextField.attributedPlaceholder = str2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func login() {
       activityView.startAnimating()
        activityView.isHidden = false
        
        APIservice.sharedInstance.login(usernameTextField.text!,password:passwordTextField.text!){ (result:Bool) in
            if result{
                APIservice.sharedInstance.generateHeaderAfterAuth()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainAuth")

            }
            else {
                self.activityView.stopAnimating()
                self.activityView.isHidden = true
            }
        }
    }
    
    func setupViews(){
        let usernameBottomLine = UIView(frame: CGRect(x: usernameTextField.frame.origin.x, y: usernameTextField.frame.origin.y + usernameTextField.frame.height, width: usernameTextField.frame.size.width, height: 0.5))
        usernameBottomLine.backgroundColor = UIColor.white
        usernameBottomLine.isOpaque = true
        
        
        let passwordBottomLine = UIView(frame: CGRect(x: passwordTextField.frame.origin.x, y: passwordTextField.frame.origin.y + passwordTextField.frame.height, width: passwordTextField.frame.size.width, height: 0.5))
        passwordBottomLine.backgroundColor = UIColor.white
        passwordBottomLine.isOpaque = true
        
        view.addSubview(usernameBottomLine)
        view.addSubview(passwordBottomLine)
    }

    //delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (usernameTextField.isFirstResponder){
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
            login()
        }
        
        return true
    }
}

