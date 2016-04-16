//
//  ViewController.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/7.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginErrorAlert(title: String, message: String){
        //當出現錯誤時callout
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func loginsccuessAlert(title: String, message: String){
        //當出現成功時callout
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    


    @IBAction func loginAction(sender: AnyObject) {
        var username = self.usernameField.text
        var password = self.passwordField.text
        //清除空格
        username = username!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        password = password!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        //驗證使用者名稱跟密碼
        if username!.characters.count < 5 {
        self.loginErrorAlert("Opps!", message: "username must longer than 5 characters!!")
           
        }else if password!.characters.count<8 {
            self.loginErrorAlert("Opps!", message: "password must longer than 8 characters!!")
        }else{
        //驗證的旋轉動畫 
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            self.view.addSubview(spinner)
            spinner.startAnimating()
        //發送登入要求
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user, error)-> Void in
        //停止旋轉動畫
            spinner.stopAnimating()
            
        if( (user) != nil){
        self.loginsccuessAlert("Sccuess", message: "Logged In!")
            dispatch_async(dispatch_get_main_queue(), {()-> Void in
            let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Home")
            UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
            })


        }else{
        self.loginErrorAlert("Error", message: "User doesn't exit!")
        
            
                }
    
            })
        
        
        }
            
        
        
        
    }
    
    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue){ }
    
    //鍵盤自動收起
    func textFieldShouldReturn(textField: UITextField) -> Bool{
    textField.resignFirstResponder()
    return true
    
    }
   
    
    

}

