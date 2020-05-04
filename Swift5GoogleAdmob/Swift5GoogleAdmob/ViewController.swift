//
//  ViewController.swift
//  Swift5GoogleAdmob
//
//  Created by AkiyukiIshikawa on 2020/05/03.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.adUnitID = "xxxxxxx"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }

    
}

