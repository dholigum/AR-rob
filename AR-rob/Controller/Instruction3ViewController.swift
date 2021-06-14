//
//  Instruction3ViewController.swift
//  AR-rob
//
//  Created by Sholihatul Richas on 10/06/21.
//

import UIKit

class Instruction3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Instruction", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "Instruction2") as! Instruction2ViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        view.window!.layer.add(transition, forKey: kCATransition)
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: false, completion: nil)
    }
    
    @IBAction func pressedNext(_ sender: Any) {
        //Change to false user defaults value
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isNotFirstApp")
        
        // Navigate to AR Page
        
        let MainARStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainARView = MainARStoryboard.instantiateViewController(identifier: "mainARView")
        
        
        MainARView.modalPresentationStyle = .fullScreen
        self.present(MainARView, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
