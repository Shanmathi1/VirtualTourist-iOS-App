//
//  Photos.swift
//  VirtualTourist_Udacity
//
//  Created by Shanmathi Mayuram Krithivasan on 1/2/16.
//  Copyright © 2016 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Photos)

class Photos: NSManagedObject {
    
    struct Keys {
        static let ImagePath = "imagePath"
        static let URLString = "urlString"
        static let Data = "data"
        static let Title = "title"
        static let Location = "location"
    }
    
    @NSManaged var imagePath: String
    @NSManaged var urlString: String
    @NSManaged var data: NSData?
    @NSManaged var title: String
    @NSManaged var location: Location
    var isFetchingPhoto: Bool = false
    
    var image: UIImage? {
        get {
            return FlickrClient.Caches.imageCache.imageWithIdentifier(imagePath)
        }
        
        set {
            FlickrClient.Caches.imageCache.storeImage(newValue, withIdentifier: imagePath)
        }
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("Photos", inManagedObjectContext: context)!
        
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        urlString = dictionary[Keys.URLString] as! String
        location = dictionary[Keys.Location] as! Location
        title = dictionary[Keys.Title] as! String
        imagePath = dictionary[Keys.ImagePath] as! String
    }
    
    func updatePhoto(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        urlString = dictionary[Keys.URLString] as! String
        location = dictionary[Keys.Location] as! Location
        title = dictionary[Keys.Title] as! String
        imagePath = dictionary[Keys.ImagePath] as! String
        
        data = nil
        isFetchingPhoto = false
    }
    
    func fetchPhoto() {
        if data == nil && isFetchingPhoto == false {
            isFetchingPhoto = true
            NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: urlString)!), queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                if error == nil {
                    self.data = data
                    self.image = UIImage(data: data!)
                    CoreDataStackManager.sharedInstance().saveContext()
                } else {
                    self.isFetchingPhoto = false
                    self.data = nil
                    CoreDataStackManager.sharedInstance().saveContext()
                }
            }
        }
    }
    
    // This deletes images in documents folder when corresponding Photo object deleted
    override func prepareForDeletion() {
        let path = FlickrClient.Caches.imageCache.pathForIdentifier(imagePath)
        let fm = NSFileManager.defaultManager()
        
        var error: NSError?
        do {
            try fm.removeItemAtPath(path)
            print("delete successful")
        } catch let error1 as NSError {
            error = error1
            print("delete unsuccessful: \(error)")
        }
    }
    
}
