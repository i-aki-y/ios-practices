//
//  ViewController.swift
//  Swift5Timer
//
//  Created by AkiyukiIshikawa on 2020/04/30.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    
    var count = Int()
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        count = 0
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        for i in 0..<5 {
            print(i)
            
            let image = UIImage(named: "\(i)")
            imageArray.append(image!)
        }
        
        imageView.image = imageArray[0]
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }

    @objc func timerUpdate() {
        count = count + 1
        if count > 4 {
            count = 0
        }
        imageView.image = imageArray[count]
        
        
    }
    
    @IBAction func start(_ sender: Any) {
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
        startTimer()
    }
    
    @IBAction func stop(_ sender: Any) {
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        timer.invalidate()

    }
}

