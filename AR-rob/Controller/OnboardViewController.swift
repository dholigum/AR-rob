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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exploreButton.backgroundColor = UIColor(hexaString: "#008B74")
        exploreButton.layer.cornerRadius = 29
        exploreButton.tintColor = .white
        
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
        
        InstructionView.modalPresentationStyle = .fullScreen
        self.present(InstructionView, animated: true, completion: nil)
        
    }
    
}
