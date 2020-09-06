//
//  ViewController.swift
//  SpeechRecognitionExample
//
//  Created by TokyoYoshida on 2020/09/05.
//  Copyright © 2020 TokyoMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textView: UITextView!
    var isStart: Bool = false
    let recognizer = SpeechRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recognizer.requestAuthorization { result in
            if result == false {
                DispatchQueue.main.async {
                    self.button.isEnabled = false
                }
            }
        }
    }
}

extension ViewController {
    @IBAction func startTapped(_ sender: Any) {
        func start() {
            isStart = true
            button.setTitle("Stop", for: .normal)
            try! recognizer.start {[weak self] str, error in
                DispatchQueue.main.async {
                    self?.textView.text = str
                }
            }
        }
        func stop() {
            isStart = false
            button.setTitle("Start", for: .normal)
            recognizer.stop()
        }

        if isStart {
            stop()
        } else {
            start()
        }
    }
}

