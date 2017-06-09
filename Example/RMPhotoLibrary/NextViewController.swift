//
//  ViewController.swift
//  RMPhotoLibrary
//
//  Created by reiya.matsuki.1990.09.23@gmail.com on 06/06/2017.
//  Copyright (c) 2017 reiya.matsuki.1990.09.23@gmail.com. All rights reserved.
//

import UIKit
import RMPhotoLibrary

class NextViewController: UIViewController{
    @IBOutlet open weak var imageView: UIImageView!
    open var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
    }
}
