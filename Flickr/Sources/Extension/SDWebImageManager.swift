//
//  SDWebImageManager.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 12..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import SDWebImage
import RxSwift

extension SDWebImageManager {
    func downloadImageWithURL(url: URL) -> Observable<UIImage> {
        // Creating an observable, that sends signals to observers when the image download has finished
        return Observable.create{ observer in
            SDWebImageManager.shared()
                .loadImage(with: url, options: .cacheMemoryOnly, progress: nil, completed: { (image, data, error, cacheType, finished, url) in
                    if let _ = error {
                        observer.onError(FlickrPhotoError.failedFetchingImage)
                    } else if let image = image {
                        observer.onNext(image)
                    }
                })
            return Disposables.create()
        }
    }
}
