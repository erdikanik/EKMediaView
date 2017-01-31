//
//  EKMediaView.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 10.01.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import UIKit
import AVFoundation

protocol EKMediaViewDelegate {
    func mediaViewPageDidChange(mediaView:EKMediaView, currentMedia:EKMedia, pageIndex:Int)
}

class EKMediaView: UIView, UIScrollViewDelegate {

    static let kPageControlBottomConstant:CGFloat = 7
    
    let scrollview:UIScrollView = UIScrollView()
    let pageControl:UIPageControl = UIPageControl()
    
    var playerItems:[AVPlayerItem]?
    var players:[AVPlayer]?
    
    var delegate: EKMediaViewDelegate?

    var stopAll:Bool? {
        didSet {
        
            guard let stopAll = stopAll else {
                return
            }
            
            if let players = players {
                
                for player in players {
                    
                    if stopAll {
                        player.seek(to: kCMTimeZero)
                        player.pause()
                    }
                    else {
                    
                        if pageControl.currentPage == currentPlayerIndex(index: pageControl.currentPage) {
                            
                            player.seek(to: kCMTimeZero)
                            player.play()
                        }
                    }
                }
            }
        }
    }
    
    var muted:Bool? {
        
        didSet {
            
            guard let muted = muted else {
                return
            }
            
            if let players = players {
                for player in players {
                    
                    player.isMuted = muted
                }
            }
        }
    }
    
    var medias:[EKMedia]? {
        
        didSet {
            layoutIfNeeded()
            
            if let medias = medias {
            
                pageControl.numberOfPages = medias.count
                pageControl.currentPage = 0
                
                initializePlayerItems()
                setContentScrollView()
            }
        }
    }
    
    var selectedPage:Int? {
        
        didSet {
            
            guard let selectedPage = selectedPage else {
                return
            }
            
            pageControl.currentPage = selectedPage
            
            stopPlayer()
            
            
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        initializeViews()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollview.frame.width
        let currentPage = floor(((scrollView.contentOffset.x - width / 2) / width)) + 1
     
        setMedia(selectedPage: Int(currentPage))
    }
}

// MARK: Media View

fileprivate extension EKMediaView {
    
    fileprivate func create(media:EKMedia, index:Int) -> UIView? {
    
        let x:CGFloat = CGFloat(index) * bounds.width
        let frame = CGRect(x: x, y: 0, width: bounds.width, height: bounds.height)
        
        switch media.type {
        case .Image:
            
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(contentsOfFile: media.url)
            
            return imageView
            
        case .Video:
            
            let videoBackground = UIView(frame: frame)
            
            let playerItem = playerItems?[currentPlayerIndex(index: index)]
            let player = AVPlayer(playerItem: playerItem)
        
            players?.append(player)
            
            if index == 0 {
                
                player.play()
            } else {
                
                player.pause()
            }
            
            let playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.frame = bounds
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            videoBackground.layer .addSublayer(playerLayer)
            
            return videoBackground
        }
        
        return nil
    }
}

// MARK: ScrollView
fileprivate extension EKMediaView {
    
    func setContentScrollView() {
    
        guard let medias = medias else {
            
            return
        }
        
        let horizontalContentSize = CGFloat(medias.count) * bounds.width
        scrollview.contentSize = CGSize(width: horizontalContentSize, height: bounds.height)
    
        for i in 0 ..< medias.count {
            
            if let view = create(media: medias[i], index: i) {
                scrollview .addSubview(view)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [weak self] notification in
            
            guard let players = self?.players, players.count > 0 else {
                return
            }
            
            if (self?.stopAll)! {
                
                if let currentPage = self?.pageControl.currentPage,
                    let index = self?.currentPlayerIndex(index: currentPage) {
                    
                    let player = players[index]
                        
                    player.seek(to: kCMTimeZero)
                    player.play()
                }
            }
        }
    }
}


// MARK: Player
fileprivate extension EKMediaView {

    fileprivate func initializePlayerItems() {
    
        guard let medias = medias else {
            return
        }
        
        playerItems = [AVPlayerItem]()
    
        for media in medias {
            
            let url = URL(fileURLWithPath: media.url)
            let playerItem = AVPlayerItem(url: url)
            
            playerItems?.append(playerItem)
        }
    }
}

// MARK: Helpers
fileprivate extension EKMediaView {
    
    fileprivate func stopPlayer() {
    
        guard let players = players else {
            return
        }
        
        for player in players {
            
            player.seek(to: kCMTimeZero)
            player.pause()
        }
    }
    
    fileprivate func currentPlayerIndex(index:Int) -> Int {
        
        guard let medias = medias else {
            return NSNotFound
        }
        
        var playerIndex = 0
        
        for i in 0 ..< medias.count {
            
            if i == index {
                
                return playerIndex
            }
            
            let media = medias[i]
            
            if media.type == .Video {
                playerIndex += 1
            }
        }
        
        return NSNotFound
    }
    
    fileprivate func setMedia(selectedPage:Int) {
    
        guard let medias = medias, let players = players else {
            return
        }
        
        pageControl.currentPage = selectedPage
        
        stopPlayer()
        
        let media:EKMedia = medias[selectedPage]
        
        if (media.type == .Video)
        {
            let player = players[currentPlayerIndex(index: selectedPage)]
            player.play()
        }
        
        if let delegate = delegate {
        
            delegate.mediaViewPageDidChange(mediaView: self, currentMedia: media, pageIndex: pageControl.currentPage)
        }
    }
}

// MARK: Initialize Views
fileprivate extension EKMediaView {
    
    fileprivate func initializeViews() {
        
        setScrollViewConstraints()
        setScrollViewProperties()
        setPageControlConstraints()
    }
    
    private func setScrollViewConstraints() {
        
        addSubview(scrollview)
        translatesAutoresizingMaskIntoConstraints = false
    
        scrollview.widthAnchor.constraint(equalTo: widthAnchor, multiplier:1).isActive = true
        scrollview.heightAnchor.constraint(equalTo: heightAnchor, multiplier:1).isActive = true
        scrollview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setScrollViewProperties() {
        
        scrollview.isPagingEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.bounces = false
        
        scrollview.delegate = self
    }

    private func setPageControlConstraints() {
        
//        addSubview(pageControl)
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        pageControl.centerXAnchor .constraint(equalTo: centerXAnchor).isActive = true
//        pageControl.bottomAnchor .constraint(equalTo: bottomAnchor, constant: EKMediaView.kPageControlBottomConstant).isActive = true
//    
//        pageControl.currentPage = 0
    }
}
