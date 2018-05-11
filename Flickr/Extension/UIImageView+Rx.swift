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
    var downloadImage: Binder<UIImage> {
        return Binder(base) { imageView, image in
            UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve, animations: { () -> Void in
                self.base.image = image
            }, completion: nil)
        }
    }
}
