//
//  FlickrService.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 9..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ModelMapper

protocol FlickrServiceProtocol {
    func getPhotos() -> Single<[FlickrPhoto]>
}

final class FlickrService: FlickrServiceProtocol {
    let provider: MoyaProvider<FlickrAPIEndPoint>

    init(provider: MoyaProvider<FlickrAPIEndPoint>) {
        self.provider = provider
    }

    func getPhotos() -> Single<[FlickrPhoto]> {
        return provider.rx
            .request(.feeds)
            .map { try $0.map(to: FlickrResponse.self).items }
    }
}
