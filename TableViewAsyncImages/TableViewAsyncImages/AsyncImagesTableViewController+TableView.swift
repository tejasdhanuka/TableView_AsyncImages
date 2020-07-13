//
//  AsyncImagesTableViewController+TableView.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/13.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import UIKit

extension AsyncImagesTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AsyncImagesCell", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
}
