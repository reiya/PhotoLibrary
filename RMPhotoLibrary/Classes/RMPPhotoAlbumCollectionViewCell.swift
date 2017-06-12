
//
//  RMPPhotoAlbumCollectionViewCell.swift
//  Pods
//
//  Created by Matsuki, Reiya (松木 玲也) on 2017/06/07.
//
//

import Foundation
import UIKit
import Photos

class RMPPhotoAlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 画像を表示する
    func setConfigure(assets: PHAsset) {
        let manager = PHImageManager()
        
        manager.requestImage(for: assets,
                             targetSize: PHImageManagerMaximumSize,//frame.size,
                             contentMode: .aspectFit,
                             options: nil,
                             resultHandler: { [weak self] (image, info) in
                                guard let wself = self, let _ = image else {
                                    return
                                }
                                wself.photoImageView?.image = image
        })
    }
}
