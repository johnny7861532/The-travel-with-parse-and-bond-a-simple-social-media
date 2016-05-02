//
//  Post.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/12.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import Foundation
import Bond
import ConvenienceKit

class Post: PFObject, PFSubclassing{
     var image: Observable<UIImage?> = Observable(nil)
     var likes: Observable<[PFUser]?> = Observable(nil)
     var photoUploadTask: UIBackgroundTaskIdentifier?
     static var imageCache: NSCacheSwift<String, UIImage>!
     @NSManaged var imageFile: PFFile?
     @NSManaged var user: PFUser?
     @NSManaged var text: PFObject?
static func parseClassName() -> String{
     return "Post"
    
    }
    
    override class func initialize(){
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken){
        // inform Parse about this subclass
        self.registerSubclass()
        
        Post.imageCache = NSCacheSwift<String, UIImage>()
        
        }
    
    
    }
    
    func uploadPost(){
        if let image = image.value{
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler{()-> Void in UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            let imageData = UIImageJPEGRepresentation(image, 0.8)!
            let imageFile = PFFile(data: imageData)
            
            imageFile!.saveInBackgroundWithBlock(nil)
            // any uploaded post should be associated with the current user
            user = PFUser.currentUser()
            self.imageFile = imageFile
        
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            
                if let error = error{
                ErrorHandling.defaultErrorHandler(error)
                }
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
        
        
        
        
        }
    
    
    
    }
    func downloadImage(){
        image.value = Post.imageCache[self.imageFile!.name]
        // if image is not downloaded yet, get it
        if (image.value == nil){
            imageFile?.getDataInBackgroundWithBlock{(data: NSData?, error:NSError?) -> Void in
              
                if let error = error{
                ErrorHandling.defaultErrorHandler(error)
                
                }
                if let data = data{
                    let image = UIImage(data: data, scale:1.0)!
                    self.image.value = image
                    
                    Post.imageCache[self.imageFile!.name] = image
                    
                    
                }
            }
            
        }
    

}
   func fetchLikes(){
    if (likes.value != nil){
    return
    }
    ParseHelper.likesForPost(self, completionBlock: {( var likes:[PFObject]?, error:NSError?)->Void in
        
        if let error = error {
       ErrorHandling.defaultErrorHandler(error)
            
        }
        // filter likes that are from users that no longer exist
        likes = likes?.filter { like in like[ParseHelper.ParseLikeFromUser] != nil }
        
        self.likes.value = likes?.map { like in
            let like = like as! PFObject
            let fromUser = like[ParseHelper.ParseLikeFromUser] as! PFUser
            
            return fromUser
        }

    
    })
    
    
    }
    func doesUserLikePost(user: PFUser)->Bool{
        if let likes = likes.value{
        
        return likes.contains(user)
        
        }else{
        return false
        
        }
    
    }
    func toggleLikePost(user:PFUser) {
        if doesUserLikePost(user){
            likes.value = likes.value?.filter{ $0 != user}
            ParseHelper.unlikePost(user, post: self)
        }else{
            likes.value?.append(user)
            ParseHelper.likePost(user, post: self)
            
        
        }
    
    }
    
    
    
    
    }
