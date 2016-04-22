//
//  ResetPasswordViewController.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/7.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!

    @IBAction func passwordReset(sender: AnyObject) {
    let email = self.emailField.text
    let finalEmail = email?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    //發送重設密碼請求
    PFUser.requestPasswordResetForEmailInBackground(finalEmail!)
    let alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to  \(finalEmail!)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //鍵盤自動收起
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
        
    }

}
