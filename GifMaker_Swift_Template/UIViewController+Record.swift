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
import AVFoundation

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
            let recordVideo = UIAlertAction(title: "Record a video", style: .default, handler: {(action) in
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
                let videoStartTime = info["_UIImagePickerControllerVideoEditingStart"] as? NSNumber
                let videoEndTime = info["_UIImagePickerControllerVideoEditingEnd"] as? NSNumber
                var duration:NSNumber?
                if let videoStartTime = videoStartTime{
                duration = NSNumber(value: videoEndTime!.floatValue-videoStartTime.floatValue)
                } else{
                    duration = nil
                }
                //UISaveVideoAtPathToSavedPhotosAlbum(mediaURL.path!, nil, nil, nil)
                //self.cropVideoToSquare(rawVideoUrl: mediaURL as URL, startTime: videoStartTime, duration: duration)
                self.convertVideoToGif(videoSourceURL: mediaURL as URL, withStartTime: videoStartTime, withDuration: duration)
                dismiss(animated: true, completion: nil)
                
            }
        
    }
    
    //to do: crop has some bugs
    public func cropVideoToSquare(rawVideoUrl videoUrl:URL, startTime start:NSNumber?, duration:NSNumber?){
//
//        AVAsset：素材库里的素材；
//        AVAssetTrack：素材的轨道；
//        AVMutableComposition ：一个用来合成视频的工程文件；
//        AVMutableCompositionTrack ：工程文件中的轨道，有音频轨、视频轨等，里面可以插入各种对应的素材；
//        AVMutableVideoCompositionLayerInstruction：视频轨道中的一个视频，可以缩放、旋转等；
//        AVMutableVideoCompositionInstruction：一个视频轨道，包含了这个轨道上的所有视频素材；
//        AVMutableVideoComposition：管理所有视频轨道，可以决定最终视频的尺寸，裁剪需要在这里进行；
//        AVAssetExportSession：配置渲染参数并渲染。

        //Create the AVAsset and AVAssetTrack
        let videoAsset = AVAsset(url: videoUrl)
        let videoTrack = videoAsset.tracks(withMediaType:AVMediaTypeVideo)[0]
        
        
        // Initialize video composition and set properties
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: (videoTrack.naturalSize.width), height: (videoTrack.naturalSize.height))
        videoComposition.frameDuration = CMTime(seconds: 1, preferredTimescale: 30)
        
        // Initialize instruction and set time range
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRange(start: kCMTimeZero, duration: CMTimeMakeWithSeconds(60, 30))
        
        
        //Center the cropped video
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        let firstTransform = CGAffineTransform(translationX: videoTrack.naturalSize.height, y: -(videoTrack.naturalSize.width - videoTrack.naturalSize.height)/2.0 )
        //Rotate 90 degrees to portrait
        let secondTransform = firstTransform.rotated(by: CGFloat(Double.pi / 2))
        let finalTransform = secondTransform
        transformer.setTransform(finalTransform, at: kCMTimeZero)
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        // Export the square video
        let exporter = AVAssetExportSession(asset: videoAsset, presetName:AVAssetExportPresetHighestQuality)
        exporter?.videoComposition = videoComposition
        let path = self.createPath()
        exporter?.outputURL = path
        exporter?.outputFileType = AVFileTypeQuickTimeMovie
        
        var croppedURL:URL?
        exporter?.exportAsynchronously(completionHandler: {
            croppedURL = exporter?.outputURL
            self.convertVideoToGif(videoSourceURL: croppedURL!, withStartTime: start, withDuration: duration)
        })
    }
    
    public func imagePickerControllerDidCancel(_ picker:UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    private func createPath()->URL {
        let documentsDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        var outputURL = documentsDirectory.appendingPathComponent("output")
        do
        {
            try FileManager.default.createDirectory(atPath: outputURL!.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError
        {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        outputURL!.appendPathComponent("output.mov")
        
        do
        {
            try FileManager.default.removeItem(at: outputURL!)
        }
        catch let error as NSError
        {
            NSLog("Unable to delete item \(error.debugDescription)")
        }
        return outputURL!
    }

//MARK:Convert video to gif method

    func convertVideoToGif(videoSourceURL:URL,withStartTime startTime:NSNumber?,withDuration duration:NSNumber?){
       
        let regift = (startTime == nil ?
            //trimmed
            Regift(sourceFileURL: videoSourceURL, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount):
            //untrimmed
            Regift(sourceFileURL: videoSourceURL, startTime: startTime!.floatValue, duration: duration!.floatValue, frameRate: kFrameRate))

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
