//
//  PostSectionHeaderView.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/29.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import UIKit


class PostSectionHeaderView: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    
    var post : Post? {
        didSet{
            if let post = post{
            usernameLabel.text = post.user?.username
            postTimeLabel.text = post.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
            }
        
        }
    
    }
   }
