//
//  NextViewController.swift
//  Swift5MapAndProtocol
//
//  Created by AkiyukiIshikawa on 2020/05/02.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit

protocol SearchLocationDelegate{
    func searchLocation(idoValue: String, keidoValue:String)
}

class NextViewController: UIViewController {

    @IBOutlet weak var idoTextField: UITextField!
    
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate: SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okAction(_ sender: Any) {
        
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        
        
        if idoTextField.text != nil && keidoTextField.text != nil{

            delegate?.searchLocation(idoValue: idoValue, keidoValue: keidoValue)

            dismiss(animated: true, completion: nil)
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
