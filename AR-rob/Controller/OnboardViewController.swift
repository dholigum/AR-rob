//
//  OnboardViewController.swift
//  AR-rob
//
//  Created by Syahrul Apple Developer BINUS on 08/06/21.
//

import UIKit

class OnboardViewController: UIViewController {

    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var exploreButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exploreButtonView.layer.cornerRadius = 29
        
    }
    
    @IBAction func toMainARPage(_ sender: UIButton) {
        
        let isNotFirstApp = UserDefaults.standard.bool(forKey: "isNotFirstApp")
        
        if isNotFirstApp == false {
            
            // Navigate to Instruction Page
            let InstructionStoryboard: UIStoryboard = UIStoryboard(name: "Instruction", bundle: nil)
            let InstructionView = InstructionStoryboard.instantiateViewController(identifier: "instructionView")
            
            InstructionView.modalPresentationStyle = .fullScreen
            self.present(InstructionView, animated: true, completion: nil)
            
        } else {
            
            // Navigate to Main AR Page
            let MainARStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let MainARView = MainARStoryboard.instantiateViewController(identifier: "mainARView")
            
            MainARView.modalPresentationStyle = .fullScreen
            self.present(MainARView, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func toInstructionPage(_ sender: UIButton) {
        
        let InstructionStoryboard: UIStoryboard = UIStoryboard(name: "Instruction", bundle: nil)
        let InstructionView = InstructionStoryboard.instantiateViewController(identifier: "instructionView")
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        InstructionView.modalPresentationStyle = .fullScreen
        self.present(InstructionView, animated: false, completion: nil)
        
    }
    
}
