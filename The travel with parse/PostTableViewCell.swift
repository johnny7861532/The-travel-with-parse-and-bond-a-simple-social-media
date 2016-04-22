//
//  PostTableViewCell.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/15.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {

@IBOutlet weak var postImageView: UIImageView!
    
@IBOutlet weak var likesIconImageView: UIImageView!

@IBOutlet weak var likesLabel: UILabel!

@IBOutlet weak var likesButton: UIButton!
    
    
@IBOutlet weak var moreButton: UIButton!
var postDisposable = DisposableType?()
var likeDisposable = DisposableType?()

    
    var post: Post?{
    didSet{
    if let post = post{
     // bind the image of the post to the 'postImage' view
    postDisposable = post.image.bindTo(postImageView.bnd_image)
    likeDisposable = post.likes.observeNew{(value:[PFUser]?)->() in
    if let value = value{
    self.likesLabel.text = self.stringFromUserList(value)
    self.likesButton.selected = value.contains(PFUser.currentUser()!)
    self.likesIconImageView.hidden = (value.count == 0)
    }else{
    self.likesLabel.text = ""
    self.likesButton.selected = false
    self.likesIconImageView.hidden = true
        
        
        }
            
            
            }
        
        
        
        }
    
    
    
    }
    }
    // Generates a comma separated list of usernames from an array (e.g. "User1, User2")
    func stringFromUserList(userList:[PFUser])-> String{
        let usernameList = userList.map{user in user.username!}
        let commaSeparatedUserList = usernameList.joinWithSeparator(",")
        return commaSeparatedUserList
    
    }
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func likesButtonTapped(sender: AnyObject) {
    post?.toggleLikePost(PFUser.currentUser()!)
    }

}
