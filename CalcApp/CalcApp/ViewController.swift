//
//  ViewController.swift
//  CalcApp
//
//  Created by AkiyukiIshikawa on 2020/04/30.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var carModel = Car()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func doAction(_ sender: Any) {
        carModel.drive()
    }
    
}

