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

// Declaring properties as optional here as Unsplash API sometimes may not return all values in every
// object or return null which leads a codable limitation.

struct Photo: Decodable, Equatable {
    let id: String?
    let urls: URLS?
    let user: User?
    let likes: Int?
    
    /*
     - This init method is to validate unit test for our Photo Property
     */
    
    init(id: String, urls: URLS, user: User, likes: Int) {
        self.id = id
        self.urls = urls
        self.user = user
        self.likes = likes
    }
    
    // MARK: - Equatable Protocol
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
}

struct URLS: Decodable, Equatable {
   let raw: String?
   let full: String?
   let regular: String?
   let small: String?
   let thumb: String?
    
    /*
     - This init method is to validate unit test
     */
    
    init(raw: String, full: String, regular: String, small: String, thumb: String) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
}

struct User: Decodable, Equatable {
    let username: String?
    
    /*
     - This init method is to validate unit test
     */
    
    init(userName: String) {
        self.username = userName
    }
}
