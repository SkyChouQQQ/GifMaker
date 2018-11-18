//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/13.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit


protocol PreviewViewControllerDelegate {
    func previewVC(preview: PreviewViewController,didSaveGif gif:Gif)
}

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var gifPreviewImageView: UIImageView!
    
    var gif:Gif?
    
    var delegate:PreviewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifPreviewImageView.image = gif?.gifImage
        
        // Customize Buttons
//        [self.shareButton.layer setCornerRadius:4.0];
//        [self.shareButton.layer setBorderColor:[[UIColor colorWithRed:255.0/255.0 green:65.0/255.0 blue:112.0/255.0 alpha:1.0] CGColor]];
//        [self.shareButton.layer setBorderWidth:1.0];
//
//        [self.saveButton.layer setCornerRadius:4.0];
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Share
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.applyTheme(withTheme: .Dark)
    }
    
    @IBAction func shareGifButtomPressed(_ sender: UIButton) {
        
        let animatedGif = NSData(contentsOf: (self.gif?.url)!)
        let itemsToShare = [animatedGif]
        let shareController = UIActivityViewController(activityItems: itemsToShare as [Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = {(activity,completed,returnItems,error) in
            if(completed){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        present(shareController,animated: true)
    }
    //MARK: - Save GIF
    
    @IBAction func createAndSave(){

        //self.delegate?.previewVC(preview: self, didSaveGif: gif!)
        
        //navigationController?.popToRootViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
