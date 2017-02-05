//
//  MediaListTableViewController.swift
//  EKMediaViewExample
//
//  Created by Erdi Kanık on 31.01.2017.
//  Copyright © 2017 ekmediaview. All rights reserved.
//

import UIKit

class MediaListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewProperties()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setTableViewProperties() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView .register(UINib.init(nibName: "EKListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EKListTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EKListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EKListTableViewCell", for: indexPath) as! EKListTableViewCell
        
        let media = MockManager().mediaViews()[indexPath.row]
        
        cell.layoutIfNeeded()
        cell.setMedia(media: media)
        
        cell.titleLabel.text = "Index: \(indexPath.row)"
        //cell.mediaView.muted = true
        
        return cell
    }

//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
//        let cell:EKListTableViewCell = cell as! EKListTableViewCell
//        
//        if let mediaView = cell.mediaView {
//            mediaView.stopAll = true
//        }
//    }
}
