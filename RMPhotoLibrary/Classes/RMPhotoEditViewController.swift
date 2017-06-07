//
//  RMPhotoEditViewController.swift
//  Pods
//
//  Created by Matsuki, Reiya (松木 玲也) on 2017/06/07.
//
//

import Foundation
import Photos

public class RMPhotoEditViewController: UIViewController{
    
    @IBOutlet weak var editImageView: UIImageView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func sendImage(_ imageView: UIImageView) {
        editImageView.image = imageView.image
        print("image set ")
    }
    
}

