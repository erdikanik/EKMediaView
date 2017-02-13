//
//  MockManager.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 21.01.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import Foundation

class MockManager {

    func mediaViews()-> [EKMedia] {
        
        var mediaArray = [EKMedia]()
        
        if let url = Bundle.main.path(forResource: "1", ofType: "jpg") {
            
            let ekmedia = EKMedia(type: .Image, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "video_1mb", ofType: "mp4") {
            
            let ekmedia = EKMedia(type: .Video, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "2", ofType: "jpg") {
            
            let ekmedia = EKMedia(type: .Image, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "train", ofType: "mov") {
            
            let ekmedia = EKMedia(type: .Video, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "3", ofType: "jpg") {
            
            let ekmedia = EKMedia(type: .Image, url: url)
            mediaArray.append(ekmedia)
        }
        
        return mediaArray
    }
    
    func mediaViews2()-> [EKMedia] {
        
        var mediaArray = [EKMedia]()
        
        if let url = Bundle.main.path(forResource: "4", ofType: "jpg") {
            
            let ekmedia = EKMedia(type: .Image, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "train", ofType: "mov") {
            
            let ekmedia = EKMedia(type: .Video, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "5", ofType: "jpg") {
            
            let ekmedia = EKMedia(type: .Image, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "dance", ofType: "mov") {
            
            let ekmedia = EKMedia(type: .Video, url: url)
            mediaArray.append(ekmedia)
        }
        
        if let url = Bundle.main.path(forResource: "6", ofType: "jpg") {
            
            let ekmedia = EKMedia(type: .Image, url: url)
            mediaArray.append(ekmedia)
        }
        
        return mediaArray
    }
}
