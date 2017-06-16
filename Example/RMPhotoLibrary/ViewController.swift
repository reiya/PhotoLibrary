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
   
    var photoEditSimpleVC: RMPhotoEditSimpleViewController!
    var photoAlbumVC: RMPhotoAlbumViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        photoEditSimpleVC = self.childViewControllers[0] as! RMPhotoEditSimpleViewController

        photoAlbumVC = self.childViewControllers[1] as! RMPhotoAlbumViewController
        photoAlbumVC.delegate = self
    }
    
    @IBAction func buttonRate(sender : AnyObject) {

    }
    
    @IBAction func goNext(_ sender:UIButton) {
        let next:NextViewController = storyboard!.instantiateViewController(withIdentifier: "nextViewController") as! NextViewController
        next.image = photoEditSimpleVC.getCrapViewImage()
        self.present(next,animated: true, completion: nil)
        
    }
    
    func sendImage(image: UIImage) {
        photoEditSimpleVC.image = image
    }
    
    func cropViewController(_ controller: RMPhotoEditViewController, didFinishCroppingImage image: UIImage) {
    }
    
    public func cropViewController(_ controller: RMPhotoEditViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        let next:NextViewController = storyboard!.instantiateViewController(withIdentifier: "nextViewController") as! NextViewController
        next.image = image
        self.present(next,animated: true, completion: nil)
        
    }
}
