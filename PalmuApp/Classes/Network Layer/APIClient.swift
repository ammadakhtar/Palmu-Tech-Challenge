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
import Alamofire

class APIClient {

    static let shared = APIClient()

    // Making Private so no other instance can be created
    
    private init() {}

    /// Loading photos from unsplash api
    /// - Parameters:
    ///   - page: Represents the page number to retrieve
    ///   - completion: callback on success/failure

    func getPhotos(page: Int, completion:@escaping (Result<[Photo], NetWorkError>)->Void) {

        AF.request(APIRouter.photos(page: page)).responseJSON { response in

            guard let data = response.data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let photosArray = try decoder.decode([Photo].self, from: data)
                completion(.success(photosArray))

            } catch let error {
                print(error)
                return completion(.failure(.decodingError("Error Decoding JSON")))
            }
        }
    }
}
