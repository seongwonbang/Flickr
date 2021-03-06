//
//  SetupViewController.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 8..
//  Copyright © 2018년 makesource. All rights reserved.
//

import ViewModelBindable
import RxSwift
import RxCocoa
import UIKit
import Moya

class SetupViewController: UIViewController {
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var startButton: UIButton!

    var disposeBag = DisposeBag()
}

// MARK: - Life Cycle
extension SetupViewController: ViewModelBindable {
    typealias ViewModel = SetupViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel(viewModel: ViewModel) {
        // Inputs
        upButton.rx.tap
            .bind(to: viewModel.upButtonTapped)
            .disposed(by: disposeBag)

        downButton.rx.tap
            .bind(to: viewModel.downButtonTapped)
            .disposed(by: disposeBag)

        startButton.rx.tap
            .bind(to: viewModel.startButtonTapped)
            .disposed(by: disposeBag)

        // Outputs
        viewModel.period
            .map { "\($0)" }
            .drive(intervalLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.photoViewModel
            .emit(onNext: { [weak self] viewModel in
                let viewController = PhotoViewController.configureWith(viewModel: viewModel)
                self?.present(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

