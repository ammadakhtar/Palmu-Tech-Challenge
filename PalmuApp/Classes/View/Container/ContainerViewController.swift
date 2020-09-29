//
// Copyright (c) 2020, Palmu Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import RxCocoa
import RxSwift

class ContainerViewController: UIViewController {
    
    // MARK: - IBOutlets and Variables
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private var activeViewController: UIViewController? {
        
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    var feedViewController = FeedViewController()
    var likedPhotosViewController = LikedPhotosViewController()

    // Used to avoid memory leaks as the subscription will not be disposed of correctly without. DisposeBag holds disposables. DisposeBag allows us not to have to dispose of each subscription individually.

    let disposeBag = DisposeBag()

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeViewController = feedViewController
        subscribeViews()
        setupSegmentControl()
    }

    // MARK: - RxSubscription

    func subscribeViews() {

        segmentedControl.rx.selectedSegmentIndex

            .subscribe (onNext: {[weak self] index in
                guard let self = self else {return}

                // switching activeViewController based on index

                if index == 0 {
                    self.activeViewController = self.feedViewController

                } else {
                    self.activeViewController = self.likedPhotosViewController
                }

            }).disposed(by: disposeBag) // disposing subscription
    }

    // MARK: - Private Methods

    private func setupSegmentControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }

    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        
        if let inActiveViewController = inactiveViewController {
            inActiveViewController.willMove(toParent: nil)
            inActiveViewController.view.removeFromSuperview()
            inActiveViewController.removeFromParent()
        }
    }
    
    private func updateActiveViewController() {
        
        if let activeViewController = activeViewController {
            addChild(activeViewController)
            activeViewController.view.frame = containerView.bounds
            containerView.addSubview(activeViewController.view)
            activeViewController.didMove(toParent: self)
        }
    }
}
