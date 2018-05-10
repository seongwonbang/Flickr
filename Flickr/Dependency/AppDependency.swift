//
//  AppDependency.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 10..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import Moya

final class AppDependency {
    lazy var flickrService: FlickrServiceProtocol = FlickrService(
        provider: MoyaProvider<FlickrAPIEndPoint>()
    )

    func photoViewModel(interval: Int) -> PhotoViewModel {
        return PhotoViewModel(interval: interval, service: self.flickrService)
    }
}
