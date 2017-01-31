//
//  EKListTableViewCell.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 31.01.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import UIKit

class EKListTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaView: EKMediaView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMedia(media:EKMedia) {
        
        mediaView.medias = [media]
        mediaView.layoutSubviews()
        mediaView.pageControl.isHidden = true
    }
    
}
