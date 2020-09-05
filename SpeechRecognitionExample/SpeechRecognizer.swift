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
    var audioEngine: AVAudioEngine!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    var recognitionTask: SFSpeechRecognitionTask?
    var isEnabled: Bool = false
    
    init() {
        audioEngine = AVAudioEngine()
    }
    
    // Asks the user for privacy regarding microphone usage and speech recognition
    func requestAuthorization(completion: @escaping (Bool)->Void) {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            let authorized = authStatus == SFSpeechRecognizerAuthorizationStatus.authorized
            completion(authorized)
        }
    }
    
    // start the speech recognition session
    func start(completion: @escaping (String?, Error?)->Void) throws {
        func cancelIfOldSessionAlive() {
            if let recognitionTask = self.recognitionTask {
                recognitionTask.cancel()
                self.recognitionTask = nil
            }
        }

        func buildRecognitionRequest() -> SFSpeechAudioBufferRecognitionRequest {
            let request = SFSpeechAudioBufferRecognitionRequest()
            request.shouldReportPartialResults = true
            return request
        }

        func buildAudioSession() throws -> AVAudioSession  {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            return audioSession
        }
        
        func setToSendVoiceToRecognizer() {
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, time) in
                self?.recognitionRequest.append(buffer)
            }
        }
        
        func buildRecognitionTask() {
            recognitionTask = recognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                if let error = error {
                    completion(nil, error)
                }
                guard let str = result?.bestTranscription.formattedString else {
                    return
                }
                completion(str, nil)
            })
        }

        cancelIfOldSessionAlive()
        recognitionRequest = buildRecognitionRequest()
        _ = try buildAudioSession()
        setToSendVoiceToRecognizer()
        audioEngine.prepare()
        try audioEngine.start()
        buildRecognitionTask()
    }

    // stop the speech recognition session
    func stop() {
        guard audioEngine != nil ,recognitionRequest != nil else {
            assertionFailure("logic error")
            return
        }
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest.endAudio()
    }
}
