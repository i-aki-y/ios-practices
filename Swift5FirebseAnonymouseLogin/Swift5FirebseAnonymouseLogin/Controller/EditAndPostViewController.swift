//
//  EditAndPostViewController.swift
//  Swift5FirebseAnonymouseLogin
//
//  Created by AkiyukiIshikawa on 2020/05/05.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import Firebase

class EditAndPostViewController: UIViewController, UITextFieldDelegate {

    var passedImage = UIImage()
    
    var userName = String()
    var userImageString = String()
    var userImageData  = Data()
    var userImage = UIImage()
    
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    let screenSize = UIScreen.main.bounds.size
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTextField.delegate = self
        
        if UserDefaults.standard.object(forKey: "userName") != nil{

            userName = UserDefaults.standard.object(forKey: "userName")  as! String
        }
        
        if UserDefaults.standard.object(forKey: "userImage") != nil{

            userImageData = UserDefaults.standard.object(forKey: "userImage")  as! Data
            userImage = UIImage(data: userImageData)!
        }
        
        userProfileImageView.image = userImage
        userNameLabel.text = userName
        contentImageView.image = passedImage
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(EditAndPostViewController.keyboardWillShowNotification(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EditAndPostViewController.keyboardWillHideNotification(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @IBAction func postAction(_ sender: Any) {

        let timelineDB = Database.database().reference().child("timeline").childByAutoId()
        
        let storage = Storage.storage().reference(forURL: "gs://XXXXXXXXXXXXXXXXXX")
        
        let key = timelineDB.child("Users").childByAutoId().key
        let key2 = timelineDB.child("Contents").childByAutoId().key
        

        let imageRef = storage.child("Users").child("\(String(describing: key!)).jpg")
        let imageRef2 = storage.child("Contents").child("\(String(describing: key2!)).jpg")

        var userProfileImageData:Data = Data()
        var contentImageData:Data = Data()
        
        if userProfileImageView.image != nil{
            
            userProfileImageData = (userProfileImageView.image?.jpegData(compressionQuality: 0.01))!
        
        }

        if contentImageView.image != nil{
            
            contentImageData = (contentImageView.image?.jpegData(compressionQuality: 0.01))!
        
        }

        let uploadTask = imageRef.putData(userProfileImageData, metadata: nil){
            (metaData, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            let uploadTask2 = imageRef2.putData(contentImageData, metadata: nil) { (metaData, error2) in
                if error != nil{
                    print(error2)
                    return
                }
                
                imageRef.downloadURL { (url, dl_error) in
                    if url != nil{
                        imageRef2.downloadURL { (url2, dl_errror2) in
                            if url2 != nil{
                                
                                let timelineInfo = [
                                    "userName": self.userName as Any,
                                    "userProfileImage": url?.absoluteString as Any,
                                    "contents": url2?.absoluteString as Any,
                                    "comment": self.commentTextField.text as Any,
                                    "postDate": ServerValue.timestamp()
                                ] as [String:Any]
                                
                                timelineDB.updateChildValues(timelineInfo)
                                
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
        
        uploadTask.resume()
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    @objc func keyboardWillShowNotification(_ notification:NSNotification){
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        commentTextField.frame.origin.y = screenSize.height - keyboardHeight - commentTextField.frame.height
    }
    
    
    
    @objc func keyboardWillHideNotification(_ notification:NSNotification){

        commentTextField.frame.origin.y = screenSize.height - commentTextField.frame.height

        guard let rect = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        
        UIView.animate(withDuration: duration){
            let transform = CGAffineTransform(translationX: 0, y: 0)
            
            self.view.transform = transform
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
