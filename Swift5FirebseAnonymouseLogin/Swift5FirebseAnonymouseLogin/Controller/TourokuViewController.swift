//
//  TourokuViewController.swift
//  Swift5FirebseAnonymouseLogin
//
//  Created by AkiyukiIshikawa on 2020/05/04.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import Firebase

class TourokuViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().signInAnonymously { (authResult, error) in
            let user = authResult?.user
            print(user)
            
            let inputVC = self.storyboard?.instantiateViewController(identifier: "inputVC") as! InputViewController
            
            self.navigationController?.pushViewController(inputVC, animated: true)
            
            
        }

    }

    
    @IBAction func login(_ sender: Any) {
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
