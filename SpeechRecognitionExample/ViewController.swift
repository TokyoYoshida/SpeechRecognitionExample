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
    let recognizer = SpeechRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recognizer.requestAuthorization { result in
            if result == false {
                self.button.isEnabled = false
            }
        }
    }
}

extension ViewController {
    @IBAction func buttonTapped(_ sender: Any) {
        print("tap")
    }
}

