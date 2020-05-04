//
//  ViewController.swift
//  Swift5CameraAlbum
//
//  Created by AkiyukiIshikawa on 2020/05/03.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var backImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization {(status) in
            switch(status){
            case .authorized:
                    print("許可されています")
            case .denied:
                    print("拒否された")

            case .notDetermined:
                    print("未定")

            case .restricted:
                    print("制限")

            }
        }
    }


    @IBAction func openCamera(_ sender: Any) {
        
        let sourceType = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            
            let cameraPicker = UIImagePickerController()
            
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
            
        } else {
            print("エラー")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
            
        } else {
            print("エラー")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            backImageView.image = pickedImage
            
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
                
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func share(_ sender: Any) {
        
        let text = ""
        let image = backImageView.image?.jpegData(compressionQuality: 0.2)
        
        let items = [text, image] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
}

