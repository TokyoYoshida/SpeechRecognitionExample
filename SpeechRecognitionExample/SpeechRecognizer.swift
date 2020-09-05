//
//  SpeechRecognition.swift
//  SpeechRecognitionExample
//
//  Created by TokyoYoshida on 2020/09/05.
//  Copyright © 2020 TokyoMac. All rights reserved.
//

import Foundation
import Speech
import AVFoundation

class SpeechRecognizer {
    let recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja_JP"))!
    var isEnabled: Bool = false
    
    // Asks the user for privacy regarding microphone usage and speech recognition
    func requestAuthorization(completion: @escaping (Bool)->Void) {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            let authorized = authStatus == SFSpeechRecognizerAuthorizationStatus.authorized
            completion(authorized)
        }
    }
}
