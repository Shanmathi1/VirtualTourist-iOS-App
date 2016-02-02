//
//  DataHelper.swift
//  VirtualTourist_Udacity
//
//  Created by Shanmathi Mayuram Krithivasan on 1/2/16.
//  Copyright © 2016 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import Foundation
import UIKit

class DataHelper: NSObject {
    
    class func updateCurrentView(view : UIView, withActivityIndicator activityIndicator: UIActivityIndicatorView, andAnimate enable: Bool) {
        if enable {
            view.alpha = 0.6
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        } else {
            view.alpha = 1
            activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
        }
    }
    
    class func raiseInformationalAlert(inViewController viewController: UIViewController, withTitle title: String, message: String, completionHandler: ((UIAlertAction!) -> Void)) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //Add Actions to UIAlertController
        alertVC.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: completionHandler))
        
        viewController.presentViewController(alertVC, animated: true, completion: nil)
        
        return alertVC
    }
    
}
