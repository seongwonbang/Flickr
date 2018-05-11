//
//  PhotoViewModel.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 9..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

final class PhotoViewModel: Reactor {
    enum Action {
        case loadPhotos
        case loadNext
    }

    enum Mutation {
        case loadPhotos([FlickrPhoto])
        case loadNext
    }

    struct State {
        var photos: [FlickrPhoto]
        var currentIndex: Int
        var isLoading: Bool
    }

    let period: Int
    let service: FlickrServiceProtocol
    let initialState: State

    init (period: Int, service: FlickrServiceProtocol) {
        self.period = period
        self.service = service
        self.initialState = State(photos: [], currentIndex: 0, isLoading: true)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadPhotos:
            return service.getPhotos()
                .map(Mutation.loadPhotos)
                .asObservable()
        case .loadNext:
            return .just(.loadNext)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .loadPhotos(let photos):
            state.photos.append(contentsOf: photos)
            state.isLoading = false
        case .loadNext:
            state.currentIndex += 1
        }
        return state
    }
}
