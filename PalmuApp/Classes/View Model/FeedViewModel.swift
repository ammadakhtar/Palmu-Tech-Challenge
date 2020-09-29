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

class FeedViewModel: BaseViewModel {
    
    // MARK :- Variables
    
    private var _photos = [Photo]()
    private let _isLoading = BehaviorRelay<Bool>(value: false)

    var pageNumber = 1

    var isLoading: Driver<Bool> { // using Driver as it enusres UI updation on main thread
        return _isLoading.asDriver()
    }

    var photos : [Photo] {
        return _photos
    }

    // MARK: - API Call Method
    
    func getUnSplashPhotos(completion: @escaping () -> Void) {

        if pageNumber == 1 {
            _isLoading.accept(true) // only show on first page
        }

        APIClient.shared.getPhotos(page: pageNumber) { result in
            self._isLoading.accept(false)

            /* Putting this block on the main queue because our completion handler is where the data display code will happen and we don't want to block any UI code. */
            
            DispatchQueue.main.async() { [weak self] in

                guard let self = self else { return }
                
                switch result {
                    
                case .success(let photos):

                    if self.pageNumber == 1 {
                        self._photos = photos  // first call
                        
                    } else {
                        self._photos.append(contentsOf: photos) // appending data to existing dataSource
                    }
                    
                    completion()
                    
                case .failure(let error):
                    AlertBuilder.failureAlertWithMessage(message: error.localizedDescription)
                }
            }
        }
    }

    func likePhoto(index: Int) {
        let imageUrl = photos[index].urls?.regular
        let userName = photos[index].user?.username
        let likes = photos[index].likes

        let data = [
            "imageUrl": imageUrl.orEmpty,
            "userName": userName.orEmpty,
            "likes": likes.orZero] as [String : Any]

        // Creating Document Reference

        let docRef = dbCollection.whereField("imageUrl", isEqualTo: imageUrl.orEmpty).limit(to: 1)

        // Checking if user has already liked the photo at current index
    
        docRef.getDocuments { (querysnapshot, error) in

            if error != nil {
                AlertBuilder.failureAlertWithMessage(message: error?.localizedDescription ?? "Could not connect to Database")

            } else {

                if let doc = querysnapshot?.documents, !doc.isEmpty {
                    // Document is already present
                    return

                } else {

                    // Adding picture to LikedPhotos DataBase
                    
                    self.dbCollection.document().setData(data) { (error) in

                        if error != nil {
                            AlertBuilder.failureAlertWithMessage(message: error?.localizedDescription ?? "Could not add image to Database")
                        }
                    }
                }
            }
        }
    }

    // MARK: - Data For Kolada View

    func imageUrl(for index: Int) -> URL? {

        let url = photos[index].urls?.regular

        if let url = URL(string: url.orEmpty) {
            return url
        }
        return nil
    }
}
