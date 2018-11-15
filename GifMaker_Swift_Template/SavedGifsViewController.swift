//
//  SavedGifsVewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/15.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class SavedGifsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PreviewViewControllerDelegate {
    
    //MARK:- save GIF from PreviewViewController
    @IBAction func saveNewgifFromPreviewVC(_ segue:UIStoryboardSegue){
        if segue.identifier == "saveNewgifFromPreviewVCSegueIditifier",  let previewVC = segue.source as? PreviewViewController{
            self.gifs.append(previewVC.gif!)

            collectionView.reloadData()
        }
    }
    //MARK:- save GIF with PreviewViewControllerDelegate method
    
    func previewVC(preview: PreviewViewController, didSaveGif gif: Gif) {
//        let gifData = NSData(contentsOf: gif.url)
//        print("before appended,number of gifs stored is \(gifs.count)")
//         print("new gifs caption is \(gif.caption)")
//        self.gifs.append(gif)
//        print("previewVC is called")
//        print("after appended,number of gifs stored is \(gifs.count)")
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIImageView!
    var gifs = [Gif]()
    let collectionViewCellMargin:CGFloat = 12.0
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyView.isHidden = (gifs.count != 0)
      
        collectionView.reloadData()
        
        //print("number of gifs stored is \(gifs.count)")
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width/2-(collectionViewCellMargin*2.0)/2.0
            return CGSize(width: width, height: width)
    }
    
    //MARK: - UICollectionViewDelegate Method
   

    
    //MARK: - UICollectionViewDatasource Method
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath) as! GifCell
         let gif = gifs[indexPath.item]
         cell.contfigureForGif(forGif: gif)
         return cell
        
        
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
