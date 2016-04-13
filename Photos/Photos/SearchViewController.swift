//
//  SearchViewController.swift
//  Photos
//
//  Created by Vishal Satish on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchbar: UITextField!
    var searchKey: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 247.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.searchbar.frame.height))
        searchbar.leftView = paddingView
        searchbar.leftViewMode = UITextFieldViewMode.Always
        searchbar.becomeFirstResponder()
        self.navigationController?.navigationBar.topItem?.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Marker Felt", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        searchbar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.performSegueWithIdentifier("showSearchResults", sender: self)
        return true
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let receiver = segue.destinationViewController as? SearchCollectionViewController {
            receiver.searchKey = searchbar.text
        }
    }

}
