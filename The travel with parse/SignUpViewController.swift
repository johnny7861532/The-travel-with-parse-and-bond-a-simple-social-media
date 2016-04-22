//
//  SignUpViewController.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/7.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signUpErrorAlert(title: String, message: String){
        //當出現錯誤時callout
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    func signUpSuccessAlert(title: String, message: String){
        //當成功時時callout
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }


    
    @IBAction func signUpAction(sender: AnyObject) {
    let username = self.usernameField.text
    let password = self.passwordField.text
    let email = self.emailField.text
    let finalemail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    //驗證註冊資訊
        if username?.characters.count<5 {
        self.signUpErrorAlert("Opps!", message: "username must longer than 5 characters!")
        } else if password?.characters.count<8 {
        self.signUpErrorAlert("Opps!", message: "password must longer than 8 characters!")
        } else if email?.characters.count<8{
        self.signUpErrorAlert("Opps!", message: "Please type vaild email! Or you might reset your password! ")
        
        }else {
        //處理時的過場動畫
      let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            self.view.addSubview(spinner)
            spinner.startAnimating()
      let newUser = PFUser()
      newUser.username = username
      newUser.password = password
      newUser.email = email
       //非同步註冊
      newUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
      // 停止過場動畫
      spinner.stopAnimating()
        if ((error) != nil){
        self.signUpErrorAlert("Error", message: "\(error)")
        }else{
        self.signUpSuccessAlert("Sccuess", message: "signed up!")
     //利用dispatch 並行序列方法
            dispatch_async(dispatch_get_main_queue(), {()-> Void in
                let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Home")
                UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
            })
        
        
        }
                
            
            
            
            
            
            })
    
            
            
        
        
        }
    
    
    }

    //鍵盤自動收起
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
        
    }

}
