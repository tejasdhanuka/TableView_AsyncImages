//
//  AsyncImagesModel.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/13.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import Foundation
import UIKit

struct Row: Decodable {
    var title: String?
    var description: String?
    var imageHref: String?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        imageHref = try container.decodeIfPresent(String.self, forKey: .imageHref)
    }
}

struct AboutCanada: Decodable {
    var title: String
    var rows: [Row]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rows
    }
}
