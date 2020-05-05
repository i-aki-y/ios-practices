//
//  InputViewController.swift
//  Swift5FirebseAnonymouseLogin
//
//  Created by AkiyukiIshikawa on 2020/05/04.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoImageView.layer.cornerRadius = 30.0
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func done(_ sender: Any) {
        
        UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
        let data = logoImageView.image?.jpegData(compressionQuality: 0.1)
        UserDefaults.standard.set(data, forKey: "userImage")
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "nextVC") as! NextViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
    }
    
    @IBAction func imageViewTap(_ sender: Any) {
        
        let generator = UINotificationFeedbackGenerator()
        
        generator.notificationOccurred(.success)
    
        showAlert()
    }
    
    func doAlbum(){
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if info[.originalImage] as? UIImage != nil{
            let selectedImage = info[.originalImage] as! UIImage
            

            UserDefaults.standard.set(selectedImage.jpegData(compressionQuality: 0.1), forKey: "userImage")
            
            logoImageView.image = selectedImage
            
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)

        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alerrt) in
            self.doCamera()
        }

        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alerrt) in
            self.doAlbum()
        }
        
        let action3 = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)

        self.present(alertController, animated: true, completion: nil)
        
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
