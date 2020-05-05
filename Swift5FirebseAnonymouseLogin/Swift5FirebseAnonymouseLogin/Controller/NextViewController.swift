//
//  NextViewController.swift
//  Swift5FirebseAnonymouseLogin
//
//  Created by AkiyukiIshikawa on 2020/05/04.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import Photos


class NextViewController: UIViewController, UITableViewDelegate,    UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var timeLineTableView: UITableView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    var selectedImage = UIImage()
    
    var userName = String()
    var userImageData = Data()
    var userImage = UIImage()
    var commentString = String()
    var createDate = String()
    var contentImageString = String()
    var userProfileImageString = String()

    var contentsArray = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status) {
                
            case .authorized:
                print("許可されています")
            case .denied:
                print("拒否されています")
            case .notDetermined:
                print("未定")
            case .restricted:
                print("制限されています")
            }
        }
        
        
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String        }
        
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            
            userImage = UIImage(data: userImageData)!
        }

        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchContentData()
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsArray.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        userName = contentsArray[indexPath.row].userNameString
        commentString = contentsArray[indexPath.row].commentString
        createDate = contentsArray[indexPath.row].postDateString
        contentImageString = contentsArray[indexPath.row].contentImageString
        userProfileImageString = contentsArray[indexPath.row].profileImageString

        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.userName = userName
        detailVC.comment = commentString
        detailVC.date = createDate
        detailVC.contentImage = contentImageString
        detailVC.profileImage = userProfileImageString
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeLineTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let profileImageView = cell.viewWithTag(1) as! UIImageView
        
        profileImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].profileImageString), completed: nil)

        profileImageView.layer.cornerRadius = 30.0
        
        let userNameLabel = cell.viewWithTag(2) as! UILabel
        userNameLabel.text = contentsArray[indexPath.row].userNameString
        
        let dateLabel = cell.viewWithTag(3) as! UILabel
        dateLabel.text = contentsArray[indexPath.row].postDateString

        let contentImageView = cell.viewWithTag(4) as! UIImageView
        
        contentImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].contentImageString), completed: nil)

        let commentLabel = cell.viewWithTag(5) as! UILabel
        commentLabel.text = contentsArray[indexPath.row].commentString

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 579
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    @IBAction func cameraAction(_ sender: Any) {
        
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
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[.originalImage] as! UIImage
        
        let editPostVC = self.storyboard?.instantiateViewController(identifier: "editPost") as! EditAndPostViewController
        
        editPostVC.passedImage = selectedImage
        
        self.navigationController?.pushViewController(editPostVC, animated: true)

        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func fetchContentData(){
        
        let ref = Database.database().reference().child("timeline").queryLimited(toLast: 100).queryOrdered(byChild: "postDate").observe(.value){
            (snapshot) in
            
            self.contentsArray.removeAll()
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                
                for snap in snapshot {
                    
                    if let postData = snap.value as? [String:Any]{
                        let userName = postData["userName"] as? String
                        let userProfileImage = postData["userProfileImage"] as? String
                        let contents = postData["contents"] as? String
                        let comment = postData["comment"] as? String
                        
                        var postDate:CLong?
                        
                        if let postedDate = postData["postDate"] as? CLong{
                            postDate = postedDate
                        }
                        
                        let timeString = self.convertTimestamp(serverTimestamp: postDate!)
                        
                        self.contentsArray.append(Contents(
                            userNameString: userName!,
                            profileImageString: userProfileImage!,
                            contentImageString: contents!,
                            commentString: comment!,
                            postDateString: timeString
                        ))
                    }
                }
                
                self.timeLineTableView.reloadData()
                let indexPath = IndexPath(row: self.contentsArray.count - 1, section: 0)
                
                if self.contentsArray.count >= 5 {
                    self.timeLineTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
                
            }
            
        }
        
    }
    
    func convertTimestamp(serverTimestamp: CLong) -> String{
        let x = serverTimestamp/1000
        let date = Date(timeIntervalSince1970: TimeInterval(x))
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
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
