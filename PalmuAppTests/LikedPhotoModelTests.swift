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

class LikedPhotoModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Initialization Tests
    
    func testLikedPhotoModel_ForInit_ReturnsSuccess() {
        
        // Arrange
        let imageUrl = "www.dummyUrl.com"
        let userName = "Ammad Akhtar"
        let likes = 100
        
        // Act
        let sut = LikedPhoto(imageUrl: imageUrl, userName: userName, likes: likes) // sut: System Under Test
        
        // Assert
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.imageUrl, "www.dummyUrl.com")
        XCTAssertEqual(sut.userName, "Ammad Akhtar")
        XCTAssertEqual(sut.likes, 100)
    }
    
    // MARK: - Equatable Tests
    
    func testPhotoModel_ForEquatable_ReturnsSuccess() {
        
        // Arrange
        let imageUrl = "www.dummyUrl"
        let userName = "Ammad Akhtar"
        let likes = 100
        
        // Act
        let likedPhoto1 = LikedPhoto(imageUrl: imageUrl, userName: userName, likes: likes)
        let likedPhoto2 = LikedPhoto(imageUrl: imageUrl, userName: userName, likes: likes)
        
        // Assert
        XCTAssertEqual(likedPhoto1, likedPhoto2)
    }
}
