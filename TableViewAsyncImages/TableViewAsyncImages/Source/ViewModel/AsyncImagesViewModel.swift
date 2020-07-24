//
//  AsyncImagesViewModel.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/24.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import Foundation

class AsyncImagesViewModel {
    func loadJSON() {
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
                        if let
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
}
