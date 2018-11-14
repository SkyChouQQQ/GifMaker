//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/13.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

  
    @IBOutlet weak var gifImageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let testGifImage = UIImage.gif(name:"tinaFeyHiFive")
        gifImageView.image = testGifImage
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
