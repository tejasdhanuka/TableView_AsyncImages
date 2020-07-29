//
//  UIImageView+NetworkRequest.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/24.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage: UIImage) {
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = PlaceHolderImage
                }
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
