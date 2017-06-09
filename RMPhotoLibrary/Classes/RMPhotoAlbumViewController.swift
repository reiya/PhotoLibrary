//
//  RMPhotoAlbumViewController.swift
//  Pods
//
//  Created by Matsuki, Reiya (松木 玲也) on 2017/06/06.
//
//

import Foundation
import Photos

public protocol RMPhotoAlbumViewControllerDelegate: class {
    func sendImage(image: UIImage)
    func send()
}
public extension RMPhotoAlbumViewControllerDelegate {
    public func send(){
        
    }
    public func sendImage(image: UIImage) {
        
    }
}

public class RMPhotoAlbumViewController: UIViewController ,UICollectionViewDelegate{
    public weak var delegate: RMPhotoAlbumViewControllerDelegate!
    public var photoEditVC:RMPhotoEditViewController!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewCell: RMPPhotoAlbumCollectionViewCell!
    
    var photoAssets: Array! = [PHAsset]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        libraryRequestAuthorization()
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setup() {
        
        // UICollectionViewCellのマージン等の設定
//        let flowLayout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 4,
//                                     height: UIScreen.main.bounds.width / 3 - 4)
//        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
//        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.minimumLineSpacing = 6
//        
//        collectionView.collectionViewLayout = flowLayout
    }
    
    // カメラロールへのアクセス許可
    fileprivate func libraryRequestAuthorization() {
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            guard let wself = self else {
                return
            }
            switch status {
            case .authorized:
                wself.getAllPhotosInfo()
            case .denied:
                wself.showDeniedAlert()
            case .notDetermined:
                print("NotDetermined")
            case .restricted:
                print("Restricted")
            }
        })
    }
    
    // カメラロールから全て取得する
    fileprivate func getAllPhotosInfo() {
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        assets.enumerateObjects({ [weak self] (asset, index, stop) -> Void in
            guard let wself = self else {
                return
            }
            wself.photoAssets.append(asset as PHAsset)
            //最初の画像をセットする。
            wself.setConfigure(assets: wself.photoAssets[0])
            
        })
        collectionView.reloadData()
    }
    
    // カメラロールへのアクセスが拒否されている場合のアラート
    fileprivate func showDeniedAlert() {
        let alert: UIAlertController = UIAlertController(title: "アクセスエラー",
                                                         message: "「写真」へのアクセスが拒否されています。設定より変更してください。",
                                                         preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "キャンセル",
                                                  style: .cancel,
                                                  handler: nil)
        let ok: UIAlertAction = UIAlertAction(title: "設定画面へ",
                                              style: .default,
                                              handler: { [weak self] (action) -> Void in
                                                guard let wself = self else {
                                                    return
                                                }
                                                wself.transitionToSettingsApplition()
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func transitionToSettingsApplition() {
        let url = URL(string: UIApplicationOpenSettingsURLString)
        if let url = url {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        return 50
//    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RMPPhotoAlbumCollectionViewCell
        setConfigure(assets: photoAssets[indexPath.row])

        delegate.send()
    }
    func setConfigure(assets: PHAsset) {
        let manager = PHImageManager()
        
        manager.requestImage(for: assets,
                             targetSize:PHImageManagerMaximumSize,
                             contentMode: .aspectFill,
                             options: nil,
                             resultHandler: { [weak self] (image, info) in
                                guard let wself = self, let outImage = image else {
                                    return
                                }
                                if let sendImage = image {
                                    wself.delegate.sendImage(image: image!)
                                }
        })
    }
}

extension RMPhotoAlbumViewController : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RMPPhotoAlbumCollectionViewCell
        collectionViewCell.setConfigure(assets: photoAssets[indexPath.row])
        return collectionViewCell
    }
}
//extension RMPhotoAlbumViewController: UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        return 50
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photoAsset = fetchResult.object(at: indexPath.item)
//        print(photoAsset.description)
//    }
//}
