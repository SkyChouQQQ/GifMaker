//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/13.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var gifPreviewImageView: UIImageView!
    var gif:Gif?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifPreviewImageView.image = gif?.gifImage
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Share
    
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
