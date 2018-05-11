//
//  UIImageView+Rx.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 11..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import SDWebImage
import RxSwift
import RxCocoa

// MARK: - Reactive Extension
extension Reactive where Base: UIImageView {
    public var imageUrl: Binder<String?> {
        return Binder(base) { image, url in
            if let url = URL(string: url ?? "") {
                image.sd_setImageWithFade(with: url, placeholderImage: UIImage())
            }
        }

    }
}
