//
//  PhotoViewController.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 8..
//  Copyright © 2018년 makesource. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import ReactorKit
import SDWebImage
import ViewModelBindable

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var disposeBag = DisposeBag()

    static func configureWith(viewModel: ViewModel) -> PhotoViewController {
        let viewController = Storyboard.Photo.instantiate(PhotoViewController.self)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Life Cycle
extension PhotoViewController: ViewModelBindable {
    typealias ViewModel = PhotoViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel(viewModel: ViewModel) {
        let currentImage = viewModel.state
            .currentImageUrl()
            .flatMap { SDWebImageManager.shared().downloadImageWithURL(url: $0) }
            .share(replay: 1, scope: .whileConnected)

        // State binding
        currentImage
            .bind(to: imageView.rx.downloadImage)
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .map { true }
            .bind(to: self.rx.dismiss)
            .disposed(by: disposeBag)

        // Action binding
        viewModel.state
            .needPhotos()
            .map { .loadPhotos }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)

        currentImage
            .delay(RxTimeInterval(viewModel.period), scheduler: MainScheduler.instance)
            // trigger .loadNext after designated period
            .map { _ in .loadNext }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - ObservableType Extension
extension ObservableType where E == PhotoViewModel.State {
    func needPhotos() -> Observable<Void> {
        return self
            .filter { $0.photos.count < 5 }
            .map { _ in Void() }
            .observeOn(MainScheduler.asyncInstance)
    }

    func currentImageUrl() -> Observable<URL> {
        return self
            .map { URL(string: $0.photos.first?.image ?? "") }
            .filterNil()
            .distinctUntilChanged()
    }
}

