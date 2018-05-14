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
        case setLoading(Bool)
    }

    struct State {
        var photos: [FlickrPhoto]
        var isLoading: Bool
    }

    let period: Int
    let service: FlickrServiceProtocol
    let initialState: State

    init (period: Int, service: FlickrServiceProtocol) {
        self.period = period
        self.service = service
        self.initialState = State(photos: [], isLoading: false)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadPhotos:
            let photoObservable = service.getPhotos()
                .map(Mutation.loadPhotos)
                .asObservable()
            return .concat([
                .just(.setLoading(true)),
                photoObservable,
                .just(.setLoading(false)),
            ])
        case .loadNext:
            return .just(.loadNext)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .loadPhotos(let photos):
            state.photos.append(contentsOf: photos)
        case .loadNext:
            state.photos = Array(state.photos.dropFirst())
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
