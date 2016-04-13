//
//  BerkeleyCollectionViewController.swift
//  Photos
//
//  Created by Vishal Satish on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class BerkeleyCollectionViewController: UICollectionViewController {
    var photos: [Photo]!
    var selectedPhoto: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = InstagramAPI(poploc: "loc")
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        self.navigationController?.navigationBar.topItem?.title = "UC Berkeley"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Marker Felt", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 247.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    }
    
    /*
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.photos != nil {
            return self.photos.count
        } else {
            return 0
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotosCollectionViewCell", forIndexPath: indexPath) as! PhotosCollectionViewCell
        loadImageForCell(photos[indexPath.row], imageView: cell.imageView)
        cell.photo = photos[indexPath.row]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotosCollectionViewCell
        selectedPhoto = cell.photo
        return true
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage.
     It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url = NSURL(string: photo.lurl)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if error == nil {
                    imageView.image = UIImage(data: data!)
                }
            })
        })
        task.resume()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let totalHeight: CGFloat = (self.view.frame.width / 3)
        let totalWidth: CGFloat = (self.view.frame.width / 3)
        return CGSizeMake(ceil(totalWidth), ceil(totalHeight))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let receiver = segue.destinationViewController as? PhotoViewController {
            receiver.photo = selectedPhoto
        }
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}
