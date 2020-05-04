//
//  ImagesModel.swift
//  QuestionApp
//
//  Created by AkiyukiIshikawa on 2020/05/02.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import Foundation

class ImagesModel{
    
    let imageText:String
    let answer:Bool
    
    init(imageName:String, correctOrNot:Bool){
        
        imageText = imageName

        answer = correctOrNot
        
    }
    
}
