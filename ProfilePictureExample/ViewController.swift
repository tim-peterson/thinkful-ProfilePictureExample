//
//  ViewController.swift
//  ProfilePictureExample
//
//  Created by Tim Peterson on 10/30/14.
//  Copyright (c) 2014 Tim Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.alpha = 0.0
        
        let myProfilePictureURL = NSURL(string: "http://graph.facebook.com/bobdylan/picture?type=square&width=640&height=640")
 
        let activityIndictorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndictorView.center = self.view.center
        self.view.addSubview(activityIndictorView)
        activityIndictorView.startAnimating()

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // Do some async stuff
            let imageData = NSData(contentsOfURL: myProfilePictureURL)
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // Do some main thread stuff
                self.imageView.image = UIImage(data: imageData)
                activityIndictorView.stopAnimating()
                
                UIView.animateWithDuration(1.0, animations: {
                    self.imageView.alpha = 1.0
                    }, completion: {
                        (value: Bool) in
                        println("Animation complete!")
                })
            }
        }
        
        //let imageData = NSData(contentsOfURL: myProfilePictureURL)
        
        //self.imageView.image = UIImage(data: imageData)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

