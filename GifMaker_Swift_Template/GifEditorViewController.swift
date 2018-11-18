//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/13.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    var gif:Gif?
    

    // MARK: - ViewController method

    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gifImageView.image = gif?.gifImage
        self.applyTheme(withTheme: .Dark)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Observe and respond to keyboard notifications
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification:Notification){
        if (self.view.frame.origin.y >= 0) {
            
            self.view.frame.origin.y -= self.getKeyboardHeight(notification: notification)
           
        }
    }
    
    func keyboardWillHide(notification:Notification){
        if (self.view.frame.origin.y < 0) {
            
            self.view.frame.origin.y += self.getKeyboardHeight(notification:notification)
        }
        
    }
    
    func getKeyboardHeight(notification:Notification)->CGFloat{
        let userInfo = notification.userInfo!
        let keyboardFrameEndRect = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        return keyboardFrameEndRect.size.height
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Preview gif
    
    @IBAction func presentPreview(_ sender: UIBarButtonItem) {
        if let previewGifVC = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController{
            self.gif?.caption = captionTextField.text
            let reGif =  Regift(sourceFileURL: (self.gif?.videoURL)!, destinationFileURL: nil, frameCount: 16, delayTime: 0.2, loopCount: 0)
            let gifUrl = reGif.createGif(self.captionTextField.text, font:self.captionTextField.font)
            let newGif = Gif(url: gifUrl!, rawVideoUrl: (self.gif?.videoURL)!, caption: self.captionTextField.text)
            let savedGifViewVC = storyboard?.instantiateViewController(withIdentifier: "SavedGifsViewController") as! SavedGifsViewController
            previewGifVC.gif = newGif
            // set Delegate of PreviewViewControllerDelegate to SavedGifsViewController
            previewGifVC.delegate = savedGifViewVC
            

            navigationController?.pushViewController(previewGifVC, animated: true)
        }
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
