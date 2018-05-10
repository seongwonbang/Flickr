//
//  PhotoViewController.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 8..
//  Copyright © 2018년 makesource. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit
import ViewModelBindable

class PhotoViewController: UIViewController {
    static func configureWith(viewModel: ViewModel) -> PhotoViewController {
        let vc = Storyboard.Photo.instantiate(PhotoViewController.self)
        vc.viewModel = viewModel
        return vc
    }

    var disposeBag = DisposeBag()
}

extension PhotoViewController: ViewModelBindable {
    typealias ViewModel = PhotoViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bindViewModel(viewModel: ViewModel) {
    }
}
