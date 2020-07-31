//
//  AsyncImagesApiClient.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/31.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import Foundation

class AsyncImagesApiClient {
    func fetchData(completionHandler: @escaping (AboutCanada?, Error?) -> Void) {
        var task: URLSessionTask?
        guard let url = URL(string: Constants.dataUrlString) else {
            print("Incorrect URL String. Cannot form URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            if let data = data, let Str = String(data: data, encoding: .ascii),
                let data8 = Str.data(using: .utf8) {
                let aboutCanada = try! JSONDecoder().decode(AboutCanada.self, from: data8)
                completionHandler(aboutCanada, nil)
            }
        }
        task?.resume()
    }
}
