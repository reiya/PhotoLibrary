//
//  ViewController.swift
//  RMPhotoLibrary
//
//  Created by reiya.matsuki.1990.09.23@gmail.com on 06/06/2017.
//  Copyright (c) 2017 reiya.matsuki.1990.09.23@gmail.com. All rights reserved.
//

import UIKit
import RMPhotoLibrary

class ViewController: UIViewController,RMPhotoAlbumViewControllerDelegate,RMPhotoEditViewControllerDelegate{
   
    var photoEditVC: RMPhotoEditViewController!
    var photoAlbumVC: RMPhotoAlbumViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoEditVC = self.childViewControllers[0] as! RMPhotoEditViewController
        photoEditVC.showsGridMinor = false // gesture grid OFF
        photoEditVC.showsGridMajor = false // defalt grid OFF
        photoEditVC.keepAspectRatio = true
        photoEditVC.delegate = self
        //photoEditVC.cropRect = CGRect(x: 0, y: 100, width: 100, height: 100)
        
        photoAlbumVC = self.childViewControllers[1] as! RMPhotoAlbumViewController
        photoAlbumVC.delegate = self
    }
    
    @IBAction func buttonRate(sender : AnyObject) {
        photoEditVC.rate()
    }
    
    @IBAction func goNext(_ sender:UIButton) {
        photoEditVC.doneImage()
        
    }
    
    func send() {
        
    }
    
    func sendImage(image: UIImage) {
        photoEditVC.image = image
        
        //photoEditVC.cropRect = CGRect(x: 0, y: 100, width: 100, height: 100)
    }
    
    func cropViewController(_ controller: RMPhotoEditViewController, didFinishCroppingImage image: UIImage) {
    }
    
    public func cropViewController(_ controller: RMPhotoEditViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        let next:NextViewController = storyboard!.instantiateViewController(withIdentifier: "nextViewController") as! NextViewController
        next.image = image
        self.present(next,animated: true, completion: nil)
        
    }
}
