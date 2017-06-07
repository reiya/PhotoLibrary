//
//  ViewController.swift
//  RMPhotoLibrary
//
//  Created by reiya.matsuki.1990.09.23@gmail.com on 06/06/2017.
//  Copyright (c) 2017 reiya.matsuki.1990.09.23@gmail.com. All rights reserved.
//

import UIKit
import RMPhotoLibrary

class ViewController: UIViewController,RMPhotoAlbumViewControllerDelegate{
    var photoEditVC: RMPhotoEditViewController!
    var photoAlbumVC: RMPhotoAlbumViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoEditVC = self.childViewControllers[0] as! RMPhotoEditViewController
        
        photoAlbumVC = self.childViewControllers[1] as! RMPhotoAlbumViewController
        photoAlbumVC.delegate = self
    }
    func send() {
        print("コールバックきた")
    }
    
    func sendImageView(imageView: UIImageView) {
        photoEditVC.sendImage( imageView)
        print("コールバックキターーー")
    }
}
