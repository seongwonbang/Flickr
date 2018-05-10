//
//  PhotoViewModel.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 9..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import ReactorKit

final class PhotoViewModel: Reactor {

    enum Action {
        case loadPhotos
    }

    enum Mutation {
        case loadPhotos
    }

    struct State {
        var photos: [FlickrPhoto]
    }

    let interval: Int
    let service: FlickrServiceProtocol
    let initialState: State

    init (interval: Int, service: FlickrServiceProtocol) {
        self.interval = interval
        self.service = service
        self.initialState = State(photos: [])
    }

}
