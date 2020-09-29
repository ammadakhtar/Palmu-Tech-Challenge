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

import Foundation
import RxSwift
import RxCocoa

class LikedPhotosViewModel: BaseViewModel {

    private let _likedPhotos = BehaviorRelay<[LikedPhoto]>(value: [])
    private let _isLoading = BehaviorRelay<Bool>(value: false)

    var photos: Driver<[LikedPhoto]> {  // using Driver as it enusres UI updation on main thread
        return _likedPhotos.asDriver()
    }
    
    var isLoading: Driver<Bool> { // using Driver as it enusres UI updation on main thread
        return _isLoading.asDriver()
    }
    
    func getLikedPhotos() {

        _isLoading.accept(true)

        // Getting all liked photos of user from FireStore
        
        dbCollection.getDocuments { [weak self] (snapShot, error) in

            guard let self = self else { return }

            self._isLoading.accept(false)
            
            if let error = error {
                AlertBuilder.failureAlertWithMessage(message: error.localizedDescription)

            } else if let snapShot = snapShot {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                var photos = [LikedPhoto]()

                snapShot.documents.forEach { (document) in

                    if let photo = try? decoder.decode(LikedPhoto.self, fromJSONObject: document.data()) {
                        photos.append(photo)
                    }
                }
                self._likedPhotos.accept(photos)
            }
        }
    }
}
