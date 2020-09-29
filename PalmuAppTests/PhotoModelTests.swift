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

import XCTest
@testable import PalmuApp

class PhotoModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Initialization Tests

    func testPhotoModel_ForInit_ReturnsSuccess() {
        
        // Arrange
       
        let urls = URLS(raw: "www.dummyRawUrl.com", full: "www.dummyFull.com", regular: "www.dummyRegular.com", small: "www.dummySmall.com", thumb: "www.dummyThumb.com")
        let user = User(userName: "Ammad Akhtar")
        let likes = 100
        
        // Act
        
        let sut = Photo(id: "123", urls: urls, user: user, likes: likes) // sut: System Under Test
        
        // Assert
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.id, "123")
        XCTAssertEqual(sut.urls, urls)
        XCTAssertEqual(sut.user, user)
        XCTAssertEqual(sut.likes, likes)
    }

    // MARK: - Equatable Tests

    func testPhotoModel_ForEquatable_ReturnsSuccess() {
        
        // Arrange
        let urls = URLS(raw: "www.dummyRawUrl.com", full: "www.dummyFull.com", regular: "www.dummyRegular.com", small: "www.dummySmall.com", thumb: "www.dummyThumb.com")
        let user = User(userName: "Ammad Akhtar")
        let likes = 100
                     
        // Act
        let photo1 = Photo(id: "123", urls: urls, user: user, likes: likes)
        let photo2 = Photo(id: "123", urls: urls, user: user, likes: likes)

        // Assert
        XCTAssertEqual(photo1, photo2)
    }
}
