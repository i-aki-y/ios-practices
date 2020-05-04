//
//  NextViewController.swift
//  Swift5ViewTransision
//
//  Created by AkiyukiIshikawa on 2020/05/01.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var myNumber: UILabel!
    
    var givenNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myNumber.text = String(givenNumber)
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
