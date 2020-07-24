//
//  AsyncImagesTableViewController.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/13.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import UIKit
import Foundation

class AsyncImagesTableViewController: UITableViewController {
    
    var viewModel = AsyncImagesViewModel()
    
    var refreshController = UIRefreshControl()
    var isScrolling = false
    var pendingUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadJSON(onSuccess: {
            self.updateData()
        })
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
            refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        } else {
            tableView.addSubview(refreshController)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        viewModel.loadJSON(onSuccess: {
            self.updateData()
        })
        sender.endRefreshing()
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.viewModel.aboutCanada.title
            self.tableView.reloadData()
        }
    }
    
    func loadImage(imageUrl: String, index: Int) {
        var task: URLSessionTask?
        
        guard let url = URL(string: imageUrl) else {
            print("Incorrect URL String. Cannot form URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.viewModel.aboutCanada.rows?[index].image = UIImage(data: data)
            if !self.isScrolling {
                self.updateData()
            } else {
                self.pendingUpdate = true
            }
        }
        task?.resume()
    }
    
    // MARK: - scroll view delegates
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
        if pendingUpdate {
            updateData()
            pendingUpdate = false
        }
    }
}
