//
//  GuidanceText.swift
//  AR-rob
//
//  Created by Syahrul Apple Developer BINUS on 15/06/21.
//

import UIKit

extension ViewController {
    
    func changeGuidanceLabel(_ label: String) {
        DispatchQueue.main.async {
            self.guidanceLabel.text = label
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, animations: {
            self.guidanceView.alpha = 1.0
        })
    }
}
