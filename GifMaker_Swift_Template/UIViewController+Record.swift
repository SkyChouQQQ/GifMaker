//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/13.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

let frameCount = 16
let delayTime:Float = 0.2
let loopCount  = 0 // 0 means loop forever
let kFrameRate = 15



extension UIViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
   
    @IBAction func presentVideoOptions(_ sender:AnyObject){
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            launchPhotoLibrary()
        } else {
            let newGifActionSheet = UIAlertController(title: "Create new GIF", message: nil, preferredStyle: .actionSheet)
            //newGifActionSheet.view.tintColor = UIColor(displayP3Red: 1.0, green: 65.0/255.0, blue: 112.0/255.0, alpha: 1.0)
            let recordVideo = UIAlertAction(title: "record a video", style: .default, handler: {(action) in
                self.launchCamera()
            })
            let chooseFormExisting = UIAlertAction(title: "Choose from Existing Album", style: .default, handler:{(action) in
                self.launchPhotoLibrary()
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            newGifActionSheet.addAction(recordVideo)
            newGifActionSheet.addAction(chooseFormExisting)
            newGifActionSheet.addAction(cancel)
            
            present(newGifActionSheet,animated: true)
        }
    
}

    
    func launchCamera(){
        present(self.pickerControllerWithSource(pickerControllerWithSource: .camera), animated: true)
    }
    func launchPhotoLibrary(){
        present(self.pickerControllerWithSource(pickerControllerWithSource: .photoLibrary), animated: true)
    }
    
    // MARK:  - Utils
    func pickerControllerWithSource(pickerControllerWithSource sourceType:UIImagePickerControllerSourceType)->UIImagePickerController{
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = sourceType
        pickerVC.allowsEditing = true
        pickerVC.delegate = self
        pickerVC.mediaTypes = [kUTTypeMovie as String]
        return pickerVC
    }
    
//MARK:UIImagePickerControllerDelegate method
    
    public func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info :[String : Any]){
        let mediaType = (info[UIImagePickerControllerMediaType] as! String)
            if mediaType == (kUTTypeMovie as String){
                let mediaURL = info[UIImagePickerControllerMediaURL] as! NSURL
                let videoStartTime = info["_UIImagePickerControllerVideoEditingStart"] as! NSNumber
                let videoEndTime = info["_UIImagePickerControllerVideoEditingEnd"] as! NSNumber
                let duration = NSNumber(value: videoEndTime.floatValue-videoStartTime.floatValue)
                //UISaveVideoAtPathToSavedPhotosAlbum(mediaURL.path!, nil, nil, nil)
                convertVideoToGif(videoSourceURL: mediaURL as URL, withStartTime: videoStartTime.floatValue, withDuration: duration.floatValue)
                dismiss(animated: true, completion: nil)
                
            }
        
    }
    public func imagePickerControllerDidCancselel(_ picker:UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }



//MARK:Convert video to gif method

    func convertVideoToGif(videoSourceURL:URL,withStartTime startTime:Float?,withDuration duration:Float?){
       
        let regift = (startTime == nil ?
            Regift(sourceFileURL: videoSourceURL, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount):
            Regift(sourceFileURL: videoSourceURL, startTime: startTime!, duration: duration!, frameRate: kFrameRate))

        let gifURL = regift.createGif()
        let gif = Gif(url:gifURL!, rawVideoUrl:videoSourceURL, caption:nil)
        displayGif(gif: gif)
        
    }
    func displayGif(gif:Gif){
        let gifEditVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditVC.gif = gif
        navigationController?.pushViewController(gifEditVC, animated: true)
    }
}
