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
import Koloda
import Alamofire
import AlamofireImage
import Firebase
import RxSwift
import RxCocoa

class FeedViewController: UIViewController {
    
    // MARK: - IBOutlets and Variables

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var swipeCardView: KolodaView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    let viewModel = FeedViewModel()

    // Used to avoid memory leaks as the subscription will not be disposed of correctly without. DisposeBag holds disposables. DisposeBag allows us not to have to dispose of each subscription individually.

    let disposeBag = DisposeBag()
    
    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeCardView.dataSource = self
        swipeCardView.delegate = self

        bindViews()

        // Loading Data

        viewModel.getUnSplashPhotos(completion: {
            self.swipeCardView.reloadData()
        })
    }
    
    // MARK: - Private Methods

    private func bindViews() {

        // Rx-Binding

        viewModel
            .isLoading
            .drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag) // disposing Subscription

        // RxTaps
        
        likeButton.rx.tap
            .bind {
                self.swipeCardView.swipe(SwipeResultDirection.right)
        }
        .disposed(by: disposeBag) // disposing subscription

        skipButton.rx.tap
            .bind {
                self.swipeCardView.swipe(SwipeResultDirection.left)
        }
        .disposed(by: disposeBag) // disposing subscription
    }
}

extension FeedViewController: KolodaViewDataSource {

    // MARK: - KolodaViewDataSource

    // Return the number of items (views) in the KolodaView.

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return viewModel.photos.count
    }

    // Return a view to be displayed at the specified index in the KolodaView.

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        // Creating an ImageView to supply Koloda View to display
        
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.af.setImage(withURL: viewModel.imageUrl(for: index)!)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true

        // Handling pagination for smooth user experience
        // Calling API again with incremented page number when
        // the user is only 5 images away from end of the dataSource

        if index == viewModel.photos.count - 5 {
            viewModel.pageNumber += 1
            
            viewModel.getUnSplashPhotos(completion: {
                self.swipeCardView.reloadData()
            })
        }
        return view
    }
}

extension FeedViewController: KolodaViewDelegate {

    // MARK: - KolodaViewDelegate

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        if direction == .right || direction == .topRight || direction == .bottomRight {

            // Adding photo as liked in firestore backend here
            viewModel.likePhoto(index: index)
        }
    }
}
