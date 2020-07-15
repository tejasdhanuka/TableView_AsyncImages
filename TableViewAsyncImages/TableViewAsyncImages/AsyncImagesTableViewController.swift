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
    private var records: [Records] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        
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
                    let json = try JSONSerialization.jsonObject(with: data8, options: [])
                    print(json)
                } catch {
                    print("Unable to parse JSON")
                }
            }
            
        }
        task?.resume()
    }
}
