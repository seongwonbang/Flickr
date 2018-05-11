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
        // Action binding
        viewModel.state
            .loadTrigger()
            .map { .loadPhotos }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)

        viewModel.state
            .currentImage()
            .delay(RxTimeInterval(viewModel.period), scheduler: MainScheduler.instance)
            .map { _ in .loadNext }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)

        // State binding
        viewModel.state
            .currentImage()
            .bind(to: imageView.rx.imageUrl)
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .map { true }
            .bind(to: self.rx.dismiss)
            .disposed(by: disposeBag)
    }
}

extension ObservableType where E == PhotoViewModel.State {
    func loadTrigger() -> Observable<Void> {
        return self
            .filter { $0.currentIndex >= $0.photos.count - 5 }
            .map { _ in }
            .observeOn(MainScheduler.asyncInstance)
    }

    func currentImage() -> Observable<String> {
        return self
            .filter { !$0.isLoading }
            .map { $0.photos[$0.currentIndex % 2].image }
            .distinctUntilChanged()
    }
}
