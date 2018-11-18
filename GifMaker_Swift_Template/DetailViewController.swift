//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/16.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var gif:Gif?
    
    @IBOutlet weak var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gif = gif {
            self.gifImageView.image = gif.gifImage
        }
        self.applyTheme(withTheme: .DarkTranslucent)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareGifButtomPressed(_ sender: UIButton) {
        
        
        let animatedGif = NSData(contentsOf: (self.gif?.url)!)
        let itemsToShare = [animatedGif]
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare as [Any], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityVC, animated: true, completion: nil)
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
