//
//  NextViewController.swift
//  SwiftButton
//
//  Created by AkiyukiIshikawa on 2020/04/30.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

class NextViewController: UIView {

    @IBOutlet var changeLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func change(_ sender: Any) {
        changeLabel.text = "暗号が解除されました。"
    }
}
