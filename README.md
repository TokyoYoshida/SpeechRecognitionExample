# SpeechRecognition Example
Very Simple example and library for iOS Speech Recognition.

Example code.
```swift
let recognizer = SpeechRecognizer()
try! recognizer.start {[weak self] str, error in
  print(str)
}
```

<img width="300px" src="https://user-images.githubusercontent.com/16970578/92320489-c1f5f280-f05c-11ea-84cb-ca3d3413a0e6.gif">

## Use as library

1. Copy 'SpeechRecognizer.swift' to your project

2. Add the item below to `info.plist`

Privacy - Microphone Usage Description
Privacy - Speech Recognition Usage Description

3. Write Code.

for example.
```swift
class ViewController: UIViewController {
    let recognizer = SpeechRecognizer(locale: "en_US") //　If you want Japanese, please use "ja_JP"

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
