//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the (standard-res) photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    // ADDITIONAL
    /* The string of the url to the low-res photo file. */
    var lurl: String!
    /* The string of the url to the thumbnail photo file. */
    var turl: String!
    /* The date the photo was posted. */
    var date: NSDate!
    /* The string of the url to the photographer's profile picture file. */
    var purl: String!
    var liked: Bool = false

    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        self.likes = data.valueForKey("likes")?.valueForKey("count") as! Int
        self.url = data.valueForKey("images")?.valueForKey("standard_resolution")?.valueForKey("url") as! String
        self.username = data.valueForKey("user")?.valueForKey("username") as! String
        // ADDITIONAL
        self.lurl = data.valueForKey("images")?.valueForKey("low_resolution")?.valueForKey("url") as! String
        self.turl = data.valueForKey("images")?.valueForKey("thumbnail")?.valueForKey("url") as! String
        self.date = NSDate(timeIntervalSince1970: Double(data.valueForKey("created_time") as! String)!)
        self.purl = data.valueForKey("user")?.valueForKey("profile_picture") as! String
    }

}