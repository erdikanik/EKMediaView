//
//  EKMediaPageViewController.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 11.02.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import UIKit
import EKMediaView

class EKMediaPageViewController: UIViewController, EKMediaViewDelegate {

    @IBOutlet weak var mediaView: EKMediaView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initializeMediaView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mediaView.stopAll = true
        mediaView = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: EKMediaViewDelegate
    func mediaViewPageDidChange(mediaView: EKMediaView, currentMedia: EKMedia, pageIndex: Int) {
    
        if let muted = mediaView.muted {
            muteButton.isHidden = currentMedia.type == .Image
            muteButton.setBackgroundImage(UIImage(named:"mute"), for: .normal)
            
            if !muted {
                mediaView.muted = true
            }
        }
    }
    
    @IBAction func mediaViewTapped(_ sender: UITapGestureRecognizer) {
        switchMuteButton()
    }
    
    @IBAction func muteButtonTapped(_ sender: Any) {
        switchMuteButton()
    }
}

extension EKMediaPageViewController {
    
    func initializeMediaView() {
        
        mediaView.muted = true
        mediaView.delegate = self
        mediaView.medias = MockManager().mediaViews2()
        mediaView.muted = true
        mediaView.selectedPage = 0
        
        muteButton.isHidden = mediaView!.medias![0].type == .Image
    }

    func switchMuteButton()
    {
        if let muted = mediaView.muted {
            self.mediaView.muted = !muted
            
            if !muted {
                muteButton.setBackgroundImage(UIImage(named:"mute"), for: .normal)
            } else {
                muteButton.setBackgroundImage(UIImage(named:"high_volume"), for:.normal)
            }
        }
    }
}
