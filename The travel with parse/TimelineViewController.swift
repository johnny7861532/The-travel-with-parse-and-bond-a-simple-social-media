//
//  TimelineViewController.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/11.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit



class TimelineViewController: UIViewController {
    
var photoTakingHelper: PhotoTakingHelper?
var posts: [Post] = []


    @IBOutlet weak var tableView: UITableView!

    
override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
    }
    
   func takePhoto(){
        // instantiate photo taking class, provide callback for when photo  is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!,callback:{ (image: UIImage?)in
            let post = Post()
            post.image.value = image!
            post.uploadPost()
            }
            
        )
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let followingQuery = PFQuery(className: "Follow")
        ParseHelper.timelineRequestForCurrentUser{(result:[PFObject]?, error:NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            self.tableView.reloadData()
            
            }
            
        
           }
        
                }
    
        




//MARK Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }

    
   }
extension TimelineViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell")as! PostTableViewCell
        let post = posts[indexPath.row]
        post.downloadImage()
        cell.post = post
        
        return cell
    
    }

}