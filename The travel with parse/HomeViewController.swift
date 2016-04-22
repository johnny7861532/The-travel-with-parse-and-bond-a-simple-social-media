//
//  HomeViewController.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/7.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func logOutAtion(sender: AnyObject) {
    //使用者登出
    PFUser.logOut()
    //dispatch序列
        dispatch_async(dispatch_get_main_queue(), {()-> Void in
            let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //顯現使用者名稱
        if let pUserName = PFUser.currentUser()?["username"]as?String {
        self.userNameLabel.text = "Hi!" + pUserName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil){
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            
            })
        
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
