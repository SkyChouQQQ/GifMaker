//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/14.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif {
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
//    init(withName name:String){
//        gifImage = UIImage.gif(name: name)!
//    }
}
