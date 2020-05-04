//
//  SoundFile.swift
//  QuestionApp
//
//  Created by AkiyukiIshikawa on 2020/05/02.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import Foundation
import AVFoundation

class SoundFile{
    
    var player:AVAudioPlayer?
    
    func playSound(fileName:String, extensionName:String){
    
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: extensionName)
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
        } catch {
            print("エラーです")
        }
    }
}
