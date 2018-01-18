//
//  Video.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 18/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName:String?
    var title:String?
    var numberOfViews:NSNumber?
    var uploadDate:NSDate?
    
    var channel:Channel?
    
}

class Channel:NSObject {
    var name:String?
    var profileImageName:String?
}
