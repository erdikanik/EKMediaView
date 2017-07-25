//
//  EKMedia.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 10.01.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import Foundation

public enum EKMediaType {
    case Image
    case Video
}


public struct EKMedia {
    
    public init(type: EKMediaType, url: String) {
        self.type = type
        self.url = url
    }
    
    /// Media type
    public var type:EKMediaType
    
    /// File url
    public var url:String
}
