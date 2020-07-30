//
//  AsyncImagesViewModel.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/24.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class AsyncImagesViewModel {
    
    var aboutCanada: AboutCanada
    
    init(aboutCanada: AboutCanada) {
        self.aboutCanada = aboutCanada
    }
    
    func loadJSON(onCompletion: @escaping ((Bool) -> Void)) {
        var task: URLSessionTask?
        
        guard let url = URL(string: Constants.dataUrlString) else {
            print("Incorrect URL String. Cannot form URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                onCompletion(false)
                return
            }
            if let Str = String(data: data, encoding: .ascii),
               let data8 = Str.data(using: .utf8) {
                let aboutCanada = try! JSONDecoder().decode(AboutCanada.self, from: data8)
                self.aboutCanada = aboutCanada
                onCompletion(true)
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
    
//    func isInternetAvailable() -> Bool
//    {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//        return (isReachable && !needsConnection)
//    }
    
//    func isConnectedToNetwork(response: @escaping ((Bool) -> Void)) -> Bool{
//        var Status:Bool = false
//        let url = NSURL(string: "http://google.com/")
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "HEAD"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
//        request.timeoutInterval = 10.0
//        let session = URLSession.shared
//
//        session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
//            print("data \(String(describing: data))")
//            print("response \(String(describing: response))")
//            print("error \(String(describing: error))")
//
//            if let httpResponse = response as? HTTPURLResponse {
//                print("httpResponse.statusCode \(httpResponse.statusCode)")
//                if httpResponse.statusCode == 200 {
//                    Status = true
//                }
//            }
//
//        }).resume()
//        return Status
//    }
}

