//
//  OnboardViewController.swift
//  AR-rob
//
//  Created by Syahrul Apple Developer BINUS on 08/06/21.
//

import UIKit

class OnboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toMainARPage(_ sender: UIButton) {
        
        let MainARStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainARView = MainARStoryboard.instantiateViewController(identifier: "mainARView")
        
        MainARView.modalPresentationStyle = .fullScreen
        self.present(MainARView, animated: true, completion: nil)
    }
    
    @IBAction func toInstructionPage(_ sender: UIButton) {
        
        let InstructionStoryboard: UIStoryboard = UIStoryboard(name: "Instruction", bundle: nil)
        let InstructionView = InstructionStoryboard.instantiateViewController(identifier: "instructionView")
        
        InstructionView.modalPresentationStyle = .fullScreen
        self.present(InstructionView, animated: true, completion: nil)
        
    }
    
}
