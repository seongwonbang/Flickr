//
//  FlickrPhoto.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 9..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import Mapper

struct FlickrPhoto: Mappable {
    let title: String
    let link: String
    let media: Media?

    init(map: Mapper) throws {
        try title = map.from("title")
        try link = map.from("link")
        try media = map.from("media")
    }
}

struct Media: Mappable {
    let m: String

    init(map: Mapper) throws {
        try m = map.from("m")
    }
}
