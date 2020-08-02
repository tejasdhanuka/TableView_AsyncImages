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
    
    var apiClient = AsyncImagesApiClient()
    var aboutCanada: AboutCanada
    
    init(aboutCanada: AboutCanada) {
        self.aboutCanada = aboutCanada
    }
    
    func loadJSON(onCompletion: @escaping ((Bool) -> Void)) {
        apiClient.fetchData(completionHandler: { aboutCanada, error in
            if let error = error {
                print(error)
                onCompletion(false)
                return
            } else if let aboutCanada = aboutCanada {
                self.aboutCanada = aboutCanada
                onCompletion(true)
            }
        })
    }

    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return aboutCanada.rows?.count ?? 0
    }
}

