//
//  InstructionViewController.swift
//  AR-rob
//
//  Created by Syahrul Apple Developer BINUS on 08/06/21.
//

import UIKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var backToOnboardButton: UIButton!
    
    @IBOutlet weak var printBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backToOnboardButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backToOnboardButton.tintColor = .black
    }
    
    @IBAction func backToOnboardPressed(_ sender: UIButton) {
        
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "onboardView") as! OnboardViewController
        
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: true, completion: nil)
    }
    
    @IBAction func gotItButtonPressed(_ sender: UIButton) {
        
        // Change to false user defaults value
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isNotFirstApp")
        
        // Navigate to AR Page
        
        let MainARStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainARView = MainARStoryboard.instantiateViewController(identifier: "mainARView")
        
        MainARView.modalPresentationStyle = .fullScreen
        self.present(MainARView, animated: true, completion: nil)

    }
    
}
