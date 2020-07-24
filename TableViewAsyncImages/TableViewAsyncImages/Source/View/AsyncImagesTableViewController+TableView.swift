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
        return viewModel.aboutCanada.rows?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.aboutCanada.rows?[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AsyncImagesCell", for: indexPath)
        cell.imageView?.image = nil
        
        if viewModel.aboutCanada.rows?[indexPath.section].image == nil && !(viewModel.aboutCanada.rows?[indexPath.section].imageHref?.isEmpty ?? true) {
            loadImage(imageUrl: viewModel.aboutCanada.rows?[indexPath.section].imageHref ?? "", index: indexPath.section)
        } else {
            cell.imageView?.image = viewModel.aboutCanada.rows?[indexPath.section].image
        }
        
        cell.textLabel?.text = viewModel.aboutCanada.rows?[indexPath.section].description
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.sizeToFit()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tagLabel = UILabel(frame: CGRect(x: 8, y: 60, width: 200, height: 30))
        tagLabel.font = .systemFont(ofSize: 12.0)
        tagLabel.lineBreakMode = .byWordWrapping
        tagLabel.numberOfLines = 0
        tagLabel.text = viewModel.aboutCanada.rows?[indexPath.section].description
        tagLabel.sizeToFit()
        
        var imageHeight = CGFloat(0.0)
        
        if viewModel.aboutCanada.rows?[indexPath.section].image != nil {
            imageHeight = (viewModel.aboutCanada.rows?[indexPath.section].image?.size.height)! > CGFloat(60.0) ? 60.0 : viewModel.aboutCanada.rows?[indexPath.section].image?.size.height as! CGFloat
        }
        return  imageHeight >  CGFloat(tagLabel.bounds.height + 6.0) ? imageHeight : CGFloat(tagLabel.bounds.height + 6.0)
    }
    
}
