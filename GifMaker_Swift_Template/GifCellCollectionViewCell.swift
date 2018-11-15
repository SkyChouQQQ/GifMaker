//
//  GifCellCollectionViewCell.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/15.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!

    func contfigureForGif(forGif gif: Gif){
        gifImageView.image = gif.gifImage
    }

}
