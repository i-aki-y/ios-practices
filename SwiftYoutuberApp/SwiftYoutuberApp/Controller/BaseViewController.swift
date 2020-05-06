//
//  BaseViewController.swift
//  SwiftYoutuberApp
//
//  Created by AkiyukiIshikawa on 2020/05/05.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import SegementSlide

class BaseViewController: SegementSlideViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        
        scrollToSlide(at: 0, animated: true)

    }
    
    override var headerView: UIView?{
        
        let headerView = UIImageView()
        
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight:CGFloat
        if #available(iOS 11.0 , *){
            headerHeight = view.frame.size.height/4 + view.safeAreaInsets.top
        }else{
            headerHeight = view.frame.size.height/4 + topLayoutGuide.length
        }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
                
        return headerView
    }

    override var titlesInSwitcher: [String] {
        return ["トレンド", "ニュース", "天気", "おもしろ", "猫", "犬"]
    }
    
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
            
        case 0: return Page1ViewController()
        case 1: return Page1ViewController()
        case 2: return Page1ViewController()
        case 3: return Page1ViewController()
        case 4: return Page1ViewController()
        case 5: return Page1ViewController()
            
        default: return Page1ViewController()
        }
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
