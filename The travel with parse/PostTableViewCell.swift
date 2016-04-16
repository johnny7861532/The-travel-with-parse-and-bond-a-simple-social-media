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
    
    var post: Post?{
    didSet{
    if let post = post{
     // bind the image of the post to the 'postImage' view
    post.image.bindTo(postImageView.bnd_image)
            
            
            
            }
        
        
        
        }
    
    
    
    }
    


}
