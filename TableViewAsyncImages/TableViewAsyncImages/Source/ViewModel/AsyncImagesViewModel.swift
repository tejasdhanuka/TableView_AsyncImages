//
//  AsyncImagesViewModel.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/24.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import Foundation
import UIKit

class AsyncImagesViewModel {
    
    var aboutCanada: AboutCanada = AboutCanada(title: "", rows: nil) {
        didSet {
            print(aboutCanada)
        }
    }
    
    func loadJSON(onSuccess: @escaping (() -> Void)) {
        var task: URLSessionTask?
        
        guard let url = URL(string: Constants.dataUrlString) else {
            print("Incorrect URL String. Cannot form URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let Str = String(data: data, encoding: .ascii),
                let data8 = Str.data(using: .utf8) {
                let aboutCanada = try! JSONDecoder().decode(AboutCanada.self, from: data8)
                self.aboutCanada = aboutCanada
                onSuccess()
            }
        }
        task?.resume()
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
            self.aboutCanada.rows?[index].image = UIImage(data: data)
        }
        task?.resume()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return aboutCanada.rows?.count ?? 0
    }
}

