//
//  ViewController.swift
//  Swift5ViewTransision
//
//  Created by AkiyukiIshikawa on 2020/05/01.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "next"){
            let nextView = segue.destination as! NextViewController
            
            nextView.givenNumber = 123
        }
        
    }
    
    @IBAction func plus(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "sb_next") as! NextViewController
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

