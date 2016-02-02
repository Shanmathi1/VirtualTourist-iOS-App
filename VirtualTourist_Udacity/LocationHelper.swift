//
//  LocationHelper.swift
//  VirtualTourist_Udacity
//
//  Created by Shanmathi Mayuram Krithivasan on 1/2/16.
//  Copyright © 2016 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import UIKit
import MapKit

class LocationHelper: NSObject, MKAnnotation {
    var location : Location!
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(location.latitude, location.longitude)
    }
    
    var title: String? {
        return location.name!
    }
    
    init(annotationLocation:Location) {
        location = annotationLocation
        CLLocationCoordinate2DMake(location.latitude, location.longitude)
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        location.latitude = newCoordinate.latitude
        location.longitude = newCoordinate.longitude
        location.updateLocationName()
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    
    
}

