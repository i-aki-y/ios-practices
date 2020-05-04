//
//  ViewController.swift
//  Swift5Bokete
//
//  Created by AkiyukiIshikawa on 2020/05/03.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var commentTextView: UITextView!

    var apiKey = "xxxxxx"
    var count = 0
    var prevKeyword = ""
    var prevResult:JSON = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization{(status) in
            switch(status){
            case .authorized: break
            case .denied: break
            case .notDetermined: break
            case .restricted: break
                                
            }
        }
        
        // Prepare keys.plist which includes "PixabayApiKey".
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            if let keys = NSDictionary(contentsOfFile: path){
                apiKey = keys["PixabayApiKey"] as! String
            }
        }
        
        getImages(keyword: "funny")
        
    }
    
    func getImages(keyword:String){
        
        let url = "https://pixabay.com/api/?key=\(apiKey)&q=\(keyword)"
 
        print("\(keyword), \(prevKeyword)")
        
        if keyword == prevKeyword && prevResult != JSON(){

            print("reuse search result")
            
            var imageString = prevResult["hits"][self.count]["webformatURL"].string
            
            if imageString == nil {
                imageString = prevResult["hits"][0]["webformatURL"].string
                
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
            } else {

                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
            }
        }else{
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                switch(response.result) {
                    
                case .success:
                    let json:JSON = JSON(response.data as Any)
                    var imageString = json["hits"][self.count]["webformatURL"].string
                    
                    if imageString == nil {
                        imageString = json["hits"][0]["webformatURL"].string
                        
                        self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    } else {

                        self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    }
                    
                    self.prevResult = json
                    self.prevKeyword = keyword
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    
    @IBAction func nextOdai(_ sender: Any) {
        count = count + 1
        
        
        if searchTextField.text == "" {
            
            getImages(keyword: "funny")

        } else {
            
            getImages(keyword: searchTextField.text!)
            
        }
        
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        count = 0
        
        if searchTextField.text == "" {
            
            getImages(keyword: "funny")

        } else {
            
            getImages(keyword: searchTextField.text!)
            
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let shareVC = segue.destination as? ShareViewController
        
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
        
    }
}

