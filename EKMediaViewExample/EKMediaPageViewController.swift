//
//  EKMediaPageViewController.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 11.02.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import UIKit

class EKMediaPageViewController: UIViewController, EKMediaViewDelegate {

    @IBOutlet weak var mediaView: EKMediaView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: EKMediaViewDelegate
    func mediaViewPageDidChange(mediaView: EKMediaView, currentMedia: EKMedia, pageIndex: Int) {
        
        
    }
    
    @IBAction func muteButtonTapped(_ sender: Any) {
        
        self.muteButton.isSelected = !self.muteButton.isSelected
    }
}

extension EKMediaPageViewController {
    
    func initializeMediaView() {
        
        mediaView.muted = true
        mediaView.delegate = self
    
    }

}
