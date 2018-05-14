//
//  AppDependency.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 10..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import Moya

protocol SetupViewDependency {
    func photoViewModel(period: Int) -> PhotoViewModel
}

final class AppDependency: SetupViewDependency {
    lazy var flickrService: FlickrServiceProtocol = FlickrService(
        provider: MoyaProvider<FlickrAPIEndPoint>()
    )

    func photoViewModel(period: Int) -> PhotoViewModel {
        return PhotoViewModel(period: period, service: self.flickrService)
    }
}
