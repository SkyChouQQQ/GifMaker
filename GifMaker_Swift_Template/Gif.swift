//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/14.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif:NSObject,NSCoding{

    
    let url:URL
    var caption :String?
    let gifImage:UIImage?
    let videoURL:URL?
    var gifData:Data?
    
    init(url:URL, rawVideoUrl:URL, caption:String?){
        self.url = url
        self.videoURL = rawVideoUrl
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)!
        self.gifData = nil
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.url,forKey:"url")
        aCoder.encode(self.caption,forKey:"caption")
        aCoder.encode(self.gifImage,forKey:"gifImage")
        aCoder.encode(self.videoURL,forKey:"videoURL")
        aCoder.encode(self.gifData,forKey:"gifData")

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.url = aDecoder.decodeObject(forKey:"url") as! URL
        self.caption = aDecoder.decodeObject(forKey:"caption") as? String
        self.gifImage = aDecoder.decodeObject(forKey:"gifImage") as? UIImage
        self.videoURL = aDecoder.decodeObject(forKey:"videoURL") as? URL
        self.gifData = aDecoder.decodeObject(forKey:"gifData") as? Data
    }
//    init(withName name:String){
//        gifImage = UIImage.gif(name: name)!
//    }
}
