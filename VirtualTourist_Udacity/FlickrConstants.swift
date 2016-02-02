//
//  FlickrConstants.swift
//  VirtualTourist_Udacity
//
//  Created by Shanmathi Mayuram Krithivasan on 1/2/16.
//  Copyright © 2016 Shanmathi Mayuram Krithivasan. All rights reserved.
//

extension FlickrClient {
    
    // MARK: - Constants
    struct Constants {
        static let BaseURL : String = "https://api.flickr.com/services/rest/"
        static let APIKey : String = "be464884317e91b67326e805f54e813a"
        static let Extras : String = "url_m"
        static let DataFormat : String = "json"
        static let NoJSONCallbank = "1"
        static let BoundingBoxHalfWidth = 1.0
        static let BoundingBoxHalfHeight = 1.0
    }
    
    struct Methods{
        static let Search: String = "flickr.photos.search"
    }
    
}
