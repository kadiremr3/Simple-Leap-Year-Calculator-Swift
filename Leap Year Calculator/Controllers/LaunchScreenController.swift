//
//  LaunchScreenController.swift
//  Leap Year Calculator
//
//  Created by Kadir Emre on 18.06.2021.
//

import UIKit
import CLTypingLabel
import AVFoundation

class LaunchScreenController : UIViewController{
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var launchLabel: CLTypingLabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSound()
        audioPlayer.play()
        navigationController?.isNavigationBarHidden = true
        launchLabel?.text = "Leap Year Calculator"
        launchLabel?.font = UIFont(name: "Pacifico-Regular", size: 30)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.performSegue(withIdentifier: "goToViewController", sender: nil)
        }
    }
    
    func configureSound(){
        let sound = Bundle.main.path(forResource: "keyboardSound", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch{
            print(error)
        }
    }
    
}
