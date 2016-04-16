//
//  Post.swift
//  The travel with parse
//
//  Created by Johnny' mac on 2016/4/12.
//  Copyright © 2016年 Johnny' mac. All rights reserved.
//

import Foundation
import Bond

class Post: PFObject, PFSubclassing{
     var image: Observable<UIImage?> = Observable(nil)
     var photoUploadTask: UIBackgroundTaskIdentifier?
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
            saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
        
        
        
        
        }
    
    
    
    }
    func downloadImage(){
        // if image is not downloaded yet, get it
        if (image.value == nil){
            imageFile?.getDataInBackgroundWithBlock{(data: NSData?, error:NSError?) -> Void in
                if let data = data{
                    let image = UIImage(data: data, scale:1.0)!
                    self.image.value = image
                    
                }
            }
            
        }
        

}
}