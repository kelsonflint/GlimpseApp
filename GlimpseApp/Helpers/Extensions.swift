//
//  Extensions.swift
//  GlimpseApp
//
//  Created by Kelson Flint on 4/25/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import AVKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString : String?
    
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}

extension URL {
    
    func createVideoThumbnail() -> UIImage? {
        
        if let imageFromCache = imageCache.object(forKey: self as AnyObject) as? UIImage {
            return imageFromCache
        }
        
        let asset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        imageGenerator.maximumSize = CGSize(width: 250, height: 120)
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            imageCache.setObject(image as AnyObject, forKey: self as AnyObject)
            return image
        } catch let err {
            print(err)
        }
        return UIImage()
    }
}
