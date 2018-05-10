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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
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
        // initial load
        Observable.just(.loadPhotos)
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)

        Observable<Int>
            .interval(RxTimeInterval(viewModel.period), scheduler: MainScheduler.instance)
            .map { _ in ViewModel.Action.loadNext }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)

        viewModel.state
            .map { $0.currentIndex }
            .distinctUntilChanged()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .map { true }
            .bind(to: self.rx.dismiss)
            .disposed(by: disposeBag)
    }
}
