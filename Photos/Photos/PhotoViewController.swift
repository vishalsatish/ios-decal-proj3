//
//  PhotoViewController.swift
//  Photos
//
//  Created by Vishal Satish on 4/10/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tapLike: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    var liked: Bool = false
    var photo: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.username.text = photo.username
        self.liked = photo.liked
        if self.liked {
            self.likes.text = String("\(photo.likes + 1) likes")
            likeButton.setImage(UIImage(named: "liked.png"), forState: .Normal)
        } else {
            self.likes.text = String("\(photo.likes) likes")
            likeButton.setImage(UIImage(named: "unliked.png"), forState: .Normal)
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        self.date.text = dateFormatter.stringFromDate(photo.date)
        var url = NSURL(string: photo.purl)
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if error == nil {
                    let img = UIImage(data: data!)
                    self.profilePicture.image = img
                }
            })
        })
        task.resume()
        url = NSURL(string: photo.url)
        session = NSURLSession.sharedSession()
        task = session.dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if error == nil {
                    let img = UIImage(data: data!)
                    self.photoImageView.image = img
                }
            })
        })
        task.resume()
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor(red: 227.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0).CGColor
        likeButton.addTarget(self, action: #selector(buttonPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 247.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        photoImageView.userInteractionEnabled = true
        photoImageView.addGestureRecognizer(gesture)
        tapLike?.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        if self.liked {
            self.liked = false
            photo.liked = false
            likeButton.setImage(UIImage(named: "unliked.png"), forState: .Normal)
            self.likes.text = String("\(photo.likes) likes")
        } else {
            self.liked = true
            photo.liked = true
            likeButton.setImage(UIImage(named: "liked.png"), forState: .Normal)
            self.likes.text = String("\(photo.likes + 1) likes")
        }
    }
    
    func onDoubleTap(sender: UIImageView) {
        tapLike?.hidden = false
        tapLike?.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseOut, animations: {
            
            self.tapLike?.alpha = 0
            
            }, completion: {
                (value:Bool) in
                
                self.tapLike?.hidden = true
        })
        self.liked = true
        photo.liked = true
        likeButton.setImage(UIImage(named: "liked.png"), forState: .Normal)
        self.likes.text = String("\(photo.likes + 1) likes")
    }
}
