//
//  SetupViewDependency.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 12..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation

protocol SetupViewDependency {
    func photoViewModel(period: Int) -> PhotoViewModel
}
