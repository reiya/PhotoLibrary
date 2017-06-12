//
//  RMPhotoEditSimpleViewController.swift
//  Pods
//
//  Created by Matsuki, Reiya (松木 玲也) on 2017/06/12.
//
//

import Foundation

public class RMPhotoEditSimpleViewController: UIViewController {
    
    open var image: UIImage? {
        didSet {
            cropView?.image = image
        }
    }
    @IBOutlet weak  public var cropView:RMPCropView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func getCrapViewImage() -> UIImage{
        return cropView.cropImage()
    }
}
