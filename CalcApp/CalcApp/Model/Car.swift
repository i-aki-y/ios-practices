//
//  Car.swift
//  CalcApp
//
//  Created by AkiyukiIshikawa on 2020/04/30.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import Foundation

class Car{
    var frontWheel = 0
    var rearWheel = 0
    
    init(){
        frontWheel = 2
        rearWheel = 2
    }
    
    func drive(){
        
        print("前輪 \(frontWheel)")
        print("後輪 \(rearWheel)")
    }
}
