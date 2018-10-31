//
//  ViewController.swift
//  Storing Video
//
//  Created by Angelo Acero on 22/10/2018.
//  Copyright © 2018 Angelo Acero. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var minValue = 0
    let maxValue = 100
    var downloader = Timer()
    let realm = try! Realm()

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var downloadBarProgress: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadBarProgress.setProgress(0, animated: false)
        print ("Realm DB \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }

    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title:"Camera", style: .default, handler:{(action:UIAlertAction) in imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Photo Library", style: .default, handler:{(action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        imageView.image = image
        let imageURL          = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        let imageName         = imageURL!.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        let localPath         = photoURL.appendingPathComponent(imageName!)
        let image             = info[UIImagePickerController.InfoKey.originalImage]as! UIImage; imageView.image = image
        let data              = image.pngData()
        
        do
        {
            try data?.write(to: localPath!, options: Data.WritingOptions.atomic)
        }
        catch
        {
            // Catch exception here and act accordingly
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func BtnUpload_Clicked(_ sender: Any) {
        
       
        
    }
    @objc func updater(){
        if minValue != maxValue {
            minValue += 1
            downloadBarProgress.progress = Float(minValue) / Float(maxValue)
        }else{
            startButton.isEnabled = true
            minValue = 0
            downloader.invalidate()
        }
    }
    
    
    
}



