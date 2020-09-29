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

class LikedPhotoCell: UICollectionViewCell {

    @IBOutlet weak var likedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(photo: LikedPhoto) {
        titleLabel.text = photo.userName
        descriptionLabel.text = "Likes: \(photo.likes)"

        // Downloading image using alamofireImage
        // If cache exists for the URL the image is not downloaded again
        // Instead loaded from cache.
        
        if let url = URL(string: photo.imageUrl) {
            likedImageView.af.setImage(withURL: url)
        }
    }
}
