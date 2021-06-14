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
        
        //backToOnboardButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        //backToOnboardButton.tintColor = .black
        
        printBtn.layer.cornerRadius = 10
    }
    
    @IBAction func backToOnboardPressed(_ sender: UIButton) {
        
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "onboardView") as! OnboardViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        view.window!.layer.add(transition, forKey: kCATransition)
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: false, completion: nil)
    }
    
    @IBAction func printPressed(_ sender: Any) {
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Instruction", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "Instruction2") as! Instruction2ViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: false, completion: nil)
    }
    
        
//    @IBAction func gotItButtonPressed(_ sender: UIButton) {
//
//        // Change to false user defaults value
//
//        let defaults = UserDefaults.standard
//        defaults.set(true, forKey: "isNotFirstApp")
//
//        // Navigate to AR Page
//
//        let MainARStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let MainARView = MainARStoryboard.instantiateViewController(identifier: "mainARView")
//
//        MainARView.modalPresentationStyle = .fullScreen
//        self.present(MainARView, animated: true, completion: nil)
//
//    }
    
}
