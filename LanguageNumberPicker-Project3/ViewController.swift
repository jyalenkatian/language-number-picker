//
//  ViewController.swift
//  LanguageNumberPicker-Project3
//
//  Created by Joseph Yalenkatian on 2/1/17.
//  Copyright © 2017 Joseph Yalenkatian. All rights reserved.
//

import UIKit
import AVFoundation

//Function to shuffle an array
extension Array {
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //Picker Outlet
    @IBOutlet weak var NumberPicker: UIPickerView!
    
    //Label Outlets/variables for the English & Spanish messages
    @IBOutlet weak var EngMsg: UILabel!
    @IBOutlet weak var EspMsg: UILabel!
    
    //TTS variables
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    //Constant variables to store the language voice for English (US) & Spanish(Mexico)
    let setEnVoice:String = "en-US"
    let setEsVoice:String = "es-MX"

    //Sound Effect variables
    var rightSoundEffect: AVAudioPlayer!
    var wrongSoundEffect: AVAudioPlayer!
    
    //Status Circle Variable/Outlet
    @IBOutlet weak var statusCircle: UIActivityIndicatorView!
    @IBOutlet weak var rightOrWrongEmoji: UILabel!
    
    //Outlet for buttons
    @IBOutlet weak var checking: UIButton!
    @IBOutlet weak var shuffling: UIButton!
    
    //Array for storing the data for the picker
    var numberData = [["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NumberPicker.delegate = self
        NumberPicker.dataSource = self
        numberData[0].shuffle()
        numberData[2].shuffle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getNumber()
    }
    
    //Function to change the font properties for the picker
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = numberData[component][row]
        pickerLabel.font = UIFont(name: "Chalkboard SE", size: 33) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func getNumber() {
        let eng = numberData[0][NumberPicker.selectedRow(inComponent: 0)]
        let esp = numberData[2][NumberPicker.selectedRow(inComponent: 2)]
        
        rightOrWrongEmoji.isHidden = true
        statusCircle.startAnimating()

        EngMsg.text = eng
        EspMsg.text = esp

        //TTS for whatever message that will be displayed (correct or incorrect messages)
        speak(msg: EngMsg, voice: setEnVoice)
        speak(msg: EspMsg, voice: setEsVoice)
    }
    
    //Function to execute TTS
    //Accepts the label (either a number or try again msg) & the voice/language setting for that specific message to be played
    func speak(msg: UILabel!, voice: String) {
        myUtterance = AVSpeechUtterance(string: msg.text!)
        myUtterance.voice = AVSpeechSynthesisVoice(language: voice)
        myUtterance.rate = 0.4
        synth.speak(myUtterance)
    }

    @IBAction func shuffleButton(_ sender: UIButton) {
        viewDidLoad()
        EngMsg.text = "Let's Play!"
        EspMsg.text = "¡Vamos a jugar!"
        rightOrWrongEmoji.isHidden = true
        statusCircle.stopAnimating()
    }
    
    @IBAction func checkButton(_ sender: UIButton) {
        checking.isEnabled = false
        checking.alpha = 0.5
        shuffling.isEnabled = false
        shuffling.alpha = 0.5
        NumberPicker.isUserInteractionEnabled = false
        NumberPicker.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            if self.checking.isEnabled == false {
                self.checking.isEnabled = true
                self.checking.alpha = 1.0
                self.shuffling.isEnabled = true
                self.shuffling.alpha = 1.0
                self.NumberPicker.isUserInteractionEnabled = true
                self.NumberPicker.alpha = 1.0
            } else {
                //do nothing
            }
        }
        
        let eng = numberData[0][NumberPicker.selectedRow(inComponent: 0)]
        let num = numberData[1][NumberPicker.selectedRow(inComponent: 1)]
        let esp = numberData[2][NumberPicker.selectedRow(inComponent: 2)]
        
         if(eng == "zero" && esp == "cero" && num == "0")
            || (eng == "one" && esp == "uno" && num == "1")
            || (eng == "two" && esp == "dos" && num == "2")
            || (eng == "three" && esp == "tres" && num == "3")
            || (eng == "four" && esp == "cuatro" && num == "4")
            || (eng == "five" && esp == "cinco" && num == "5")
            || (eng == "six" && esp == "seis" && num == "6")
            || (eng == "seven" && esp == "siete" && num == "7")
            || (eng == "eight" && esp == "ocho" && num == "8")
            || (eng == "nine" && esp == "nueve" && num == "9")
            || (eng == "ten" && esp == "diez" && num == "10")
         {
            //If all 3 columns are a match, set the labels to the written out numbers in both languages, along with replacing the circle indicator with a green check emoji
            EngMsg.text = "Good Job!"
            EspMsg.text = "Muy Bien!"
            statusCircle.stopAnimating()
            rightOrWrongEmoji.font = UIFont(name: "Apple Color Emoji", size: 90)
            rightOrWrongEmoji.textColor = UIColor(red: 0.0784, green: 0.8039, blue: 0.1725, alpha: 1.0)
            rightOrWrongEmoji.text = "✓"
            rightOrWrongEmoji.isHidden = false
            playSound(which: "c")
         } else {
            //If no match, send a try again message, along with replacing the circle indicator with the red X emoji
            EngMsg.text = "Try again."
            EspMsg.text = "Inténtalo de nuevo."
            statusCircle.stopAnimating()
            rightOrWrongEmoji.font = UIFont(name: "Apple Color Emoji", size: 50)
            rightOrWrongEmoji.text = "❌"
            rightOrWrongEmoji.isHidden = false
            playSound(which: "w")
         }
        
        //TTS for whatever message that will be displayed (correct or incorrect messages)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.speak(msg: self.EngMsg, voice: self.setEnVoice)
            self.speak(msg: self.EspMsg, voice: self.setEsVoice)
        }
    }
    
    //Function for playing the sound when the answer is correct or incorrect
    
    func playSound(which: Character) {
        if which == "c" {
            let audioFilePath = Bundle.main.path(forResource: "Correct", ofType: "mp3")
            
            do {
                let audioFileUrl = URL(fileURLWithPath: audioFilePath!)
                
                let sound = try AVAudioPlayer(contentsOf: audioFileUrl)
                rightSoundEffect = sound
                sound.play()
                
            } catch {
                print("audio file is not found")
            }
        } else if which == "w" {
            let audioFilePath = Bundle.main.path(forResource: "Wrong", ofType: "mp3")
            
            do {
                let audioFileUrl = URL(fileURLWithPath: audioFilePath!)
                
                let sound = try AVAudioPlayer(contentsOf: audioFileUrl)
                wrongSoundEffect = sound
                sound.play()
                
            } catch {
                print("audio file is not found")
            }
        }
    }

}

