//
//  Student.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 3/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import Parse

/*
    Create User class to get the location of user to store in map.
 
 */

class Student: NSObject {
    class func postUserImage(withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        print("The user is : ", PFUser.current())
        
        post["author"] = PFUser.current()?.username
        post["occupation"] = ShareViewController.occupation
        post["firstName"] = ShareViewController.FirstName
        post["lastName"] = ShareViewController.LastName
        post["email"] = ShareViewController.email
        post["phoneNumber"] = ShareViewController.PhoneNumber
        post["history"] = ShareViewController.history
        
//        print("Longititude is : ", MapViewController.longitude as String!)
//        post["longitutude"] = MapViewController.longitude as String!
//        post["latitude"] = MapViewController.latitude as String!
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
        
    }

}
