//
//  TimelineViewController.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/11.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit
import ConvenienceKit



class TimelineViewController: UIViewController, TimelineComponentTarget{
@IBOutlet weak var tableView: UITableView!
var photoTakingHelper: PhotoTakingHelper?
var posts: [Post] = []
// TimeLineComponent
let defaultRange = 0...4
let additionalRangeSize = 5
var timelineComponent: TimelineComponent<Post, TimelineViewController>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineComponent = TimelineComponent(target: self)
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
    timelineComponent.loadInitialIfRequired()
                }
    
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
    
    ParseHelper.timelineRequestForCurrentUser(range) {
        (result: [PFObject]?, error: NSError?) -> Void in
        
        let posts = result as? [Post] ?? []
        
       
        completionBlock(posts)
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
        return timelineComponent.content.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell")as! PostTableViewCell
        let post = timelineComponent.content[indexPath.row]
        post.downloadImage()
        post.fetchLikes()
        cell.post = post
        
        return cell
    
    }

}
extension TimelineViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)

    }



}