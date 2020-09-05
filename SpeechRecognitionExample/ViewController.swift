//
//  ViewController.swift
//  SpeechRecognitionExample
//
//  Created by TokyoYoshida on 2020/09/05.
//  Copyright © 2020 TokyoMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
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
                    self.start.isEnabled = false
                    self.stop.isEnabled = false
                }
            }
        }
    }
}

extension ViewController {
    @IBAction func startTapped(_ sender: Any) {
        try! recognizer.start {[weak self] str, error in
            DispatchQueue.main.async {
                self?.textView.text = str
            }
        }
    }

    @IBAction func stopTapped(_ sender: Any) {
        recognizer.stop()
    }
}

