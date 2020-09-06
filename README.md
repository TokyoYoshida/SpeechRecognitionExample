# SpeechRecognition Example
Very Simple example and library for iOS Speech Recognition.

Example code.
```swift
let recognizer = SpeechRecognizer()
try! recognizer.start {[weak self] str, error in
  print(str)
}
```

## Use as library

1. Copy 'SpeechRecognizer.swift' to your project

2. Add the item below to `info.plist`

Privacy - Microphone Usage Description
Privacy - Speech Recognition Usage Description

3. Write Code.

for example.
```swift
class ViewController: UIViewController {
    let recognizer = SpeechRecognizer()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Asks the user for privacy regarding microphone usage and speech recognition
        recognizer.requestAuthorization { result in
            if result == false {
                DispatchQueue.main.async {
                    self.button.isEnabled = false
                }
            }
        }
    }
  @IBAction func startTapped(_ sender: Any) {
    // Start the speech recognition session
      try! recognizer.start {[weak self] str, error in
          DispatchQueue.main.async {
              print(str)
          }
      }
  }
}
```

## You can use this code as a exsample for iOS Speech Recognition

see 'SpeechRecognizer.swift'.

## License

MIT
