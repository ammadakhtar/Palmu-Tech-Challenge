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
import RxSwift
import Firebase

class LikedPhotosViewController: UIViewController {
    
    // MARK: - IBOutelts and Variables
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var viewModel = LikedPhotosViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getLikedPhotos()
    }
    
    // MARK: - Private Methods
    
    func bindViews() {
        
        // Registring Nib
        
        collectionView.register(UINib(nibName: "LikedPhotoCell", bundle: nil), forCellWithReuseIdentifier: "LikedPhotoCellIdentifier")
        
        // Rx-Binding
        
        viewModel
            .isLoading
            .drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag) // disposing Subscription
        
        viewModel
            .photos
            .drive(collectionView.rx.items(cellIdentifier: "LikedPhotoCellIdentifier", cellType: LikedPhotoCell.self))
            {  (row,photo,cell) in
                cell.configureCell(photo: photo)
        }
            .disposed(by: disposeBag) // disposing Subscription
    }
}

extension LikedPhotosViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
