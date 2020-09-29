//
//  CollectionViewCell.swift
//  PalmuApp
//
//  Created by Ammad on 26/09/2020.
//  Copyright © 2020 Palmo. All rights reserved.
//

import UIKit

class LikedPhotoCell: UICollectionViewCell {

    @IBOutlet weak var likedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func cellForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> VendorCollectionViewCell {
        let kVendorCollectionViewCellIdentifier = "kVendorCollectionViewCellIdentifier"
        collectionView.register(UINib(nibName: "VendorCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: kVendorCollectionViewCellIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kVendorCollectionViewCellIdentifier, for: indexPath) as! VendorCollectionViewCell
        return cell
    }
}
