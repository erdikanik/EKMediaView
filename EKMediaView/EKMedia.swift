//
//  EKMedia.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 10.01.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import Foundation

enum EKMediaType {
    case Image
    case Video
}


struct EKMedia {
    
    /// Media type
    var type:EKMediaType
    
    /// File url
    var url:String
}
