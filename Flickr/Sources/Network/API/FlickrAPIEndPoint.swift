//
//  FlickrAPI.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 9..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import Moya

enum FlickrAPIEndPoint {
    case feeds
}

extension FlickrAPIEndPoint: TargetType {
    var baseURL: URL { return URL(string: "https://api.flickr.com")! }

    var path: String {
        switch self {
        case .feeds:
            return "/services/feeds/photos_public.gne"
        }
    }

    var method: Moya.Method {
        switch self {
        case .feeds:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .feeds:
            let param = [
                "format": "json",
                "nojsoncallback": 1
            ] as [String : Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
