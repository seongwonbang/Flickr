//
//  FlickrResponse.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 9..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import Mapper

struct FlickrResponse: Mappable {
    let items: [FlickrPhoto]

    init(map: Mapper) throws {
        try items = map.from("items")
    }
}
