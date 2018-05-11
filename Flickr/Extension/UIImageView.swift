//
//  UIImageView.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 11..
//  Copyright © 2018년 makesource. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func sd_setImageWithFade(with url: URL, placeholderImage placeholder: UIImage, completed completedBlock: SDExternalCompletionBlock? = nil) {
        self.sd_setImage(with: url, placeholderImage: placeholder) {  (image, error, cacheType, url) -> Void in
            if let downLoadedImage = image {
//                if cacheType == .none {
//                    self.alpha = 0
                    UIView.transition(with: self, duration: 2, options: .transitionCrossDissolve, animations: { () -> Void in
                        self.image = downLoadedImage
//                        self.alpha = 1
                    }, completion: nil)
//                }
            }
            completedBlock?(image, error, cacheType, url)
        }
    }
}
