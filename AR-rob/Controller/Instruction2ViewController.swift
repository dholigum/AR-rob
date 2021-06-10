//
//  Instruction2ViewController.swift
//  AR-rob
//
//  Created by Sholihatul Richas on 10/06/21.
//

import UIKit

class Instruction2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func pressedNext(_ sender: Any) {
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Instruction", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "Instruction3") as! Instruction3ViewController
        
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: true, completion: nil)
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
