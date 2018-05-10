//
//  UIViewController+Rx.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 10..
//  Copyright © 2018년 makesource. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var dismiss: Binder<Bool> {
        return Binder(base) { viewController, animated in
            viewController.dismiss(animated: animated, completion: nil)
        }
    }
}

