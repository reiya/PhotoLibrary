//
//  RMPCropView.swift
//  Pods
//
//  Created by Matsuki, Reiya (松木 玲也) on 2017/06/12.
//
//

import UIKit

open class RMPCropView: UIView {

    var imageView:UIImageView!
    var scrollView:UIScrollView!
    open var image: UIImage? {
        didSet {
            setScrollview()
            setImage()
        }
    }
    
    func setScrollview(){
        if  scrollView != nil{
            let vWidth = self.frame.width
            let vHeight = self.frame.height
            scrollView.frame = CGRect(x:0, y:0, width:Int(vWidth), height:Int(vHeight))
        }else{
            let vWidth = self.frame.width
            let vHeight = self.frame.height
            self.backgroundColor = UIColor.white
            
            scrollView = UIScrollView()
            scrollView.delegate = self
            
            
            scrollView.alwaysBounceVertical = false
            scrollView.alwaysBounceHorizontal = false
            scrollView.showsVerticalScrollIndicator = true
            scrollView.flashScrollIndicators()
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            
            let minZoomScale = getMinimumZoomScale()
            self.scrollView.minimumZoomScale = minZoomScale
            
            scrollView.maximumZoomScale = 10.0
            self.addSubview(scrollView)
            scrollView.frame = CGRect(x:0, y:0, width:Int(vWidth), height:Int(vHeight))
        }
    }
    func setImage(){
       
        if let image = self.image{
            if imageView != nil{
                imageView.removeFromSuperview()
            }
            
            scrollView.contentSize = CGSize(width: image.size.width, height: image.size.height)
            scrollView.contentMode = .scaleAspectFill
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:  image.size.width, height: image.size.height))
            imageView.image = image
            //imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
            scrollView.zoomScale = getWidthFitZoomScale()
        }
    }
    
    func getMinimumZoomScale() -> CGFloat{
        if let image = self.image{
            return min(self.scrollView.bounds.size.width / image.size.width, self.scrollView.bounds.size.height / image.size.height)
        }
        return 1
        
    }
    func getWidthFitZoomScale() -> CGFloat{
        if let image = self.image{
            return min(self.scrollView.bounds.size.width / image.size.width, image.size.height)
        }
        return 1
    }
    func getHeightFitZoomScale() -> CGFloat{
        if let image = self.image{
            return min(image.size.width,self.scrollView.bounds.size.height / image.size.height)
        }
        return 1
    }

    func getCropRect() -> CGRect{
        let scale = 1.0 / scrollView.zoomScale;
        
        var visibleRect = CGRect()
        visibleRect.origin.x = scrollView.contentOffset.x * scale;
        visibleRect.origin.y = scrollView.contentOffset.y * scale;
        visibleRect.size.width = scrollView.bounds.size.width * scale;
        visibleRect.size.height = scrollView.bounds.size.height * scale;
        return visibleRect
    }
    
    open func cropImage() -> UIImage{
        if let image = image{
            let imageRef = image.cgImage?.cropping(to: getCropRect())
            if let imageRef = imageRef{
                return  UIImage(cgImage: imageRef)
            }
        }
        return UIImage()
        
    }
}

extension RMPCropView:UIScrollViewDelegate{
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
