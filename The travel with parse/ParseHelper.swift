//
//  ParseHelper.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/15.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import Foundation


class ParseHelper {
    static func timelineRequestForCurrentUser(completionBlock: PFQueryArrayResultBlock){
    
        let followingQuery = PFQuery(className: "Follow")
        followingQuery.whereKey("fromUser", equalTo:PFUser.currentUser()!)
        
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
        
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        query.includeKey("user")
        query.orderByDescending("createAt")
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        

    }


}
