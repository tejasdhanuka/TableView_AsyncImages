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
    
    private let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    private var navTitle: String?
    
    var records: [Record] = []
    var refreshController = UIRefreshControl()
    var isScrolling = false
    var pendingUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
            refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        } else {
            tableView.addSubview(refreshController)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        loadJSON()
        sender.endRefreshing()
    }
    
    private func loadJSON() {
        var task: URLSessionTask?
        
        guard let url = URL(string: urlString) else {
            print("Incorrect URL String. Cannot form URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let Str = String(data: data, encoding: .ascii),
                let data8 = Str.data(using: .utf8) {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data8, options: []) as! [String: Any]
                    self.navTitle = json["title"] as? String ?? ""
                    let recordsArray = json["rows"] as? [Dictionary<String, Any>] ?? []
                    self.records.removeAll()
                    for record in recordsArray {
                        let title = record["title"] as? String ?? ""
                        let description = record["description"] as? String ?? ""
                        let imageHref = record["imageHref"] as? String ?? ""
                        
                        self.records.append(Record(title: title, description: description, imageHref: imageHref, image: nil))
                        
                        self.records.sort {
                            $0.title < $1.title
                        }
                        self.updateData()
                    }
                } catch {
                    print("Unable to parse JSON")
                }
            }
            
        }
        task?.resume()
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.navTitle
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
            self.records[index].image = UIImage(data: data)
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
