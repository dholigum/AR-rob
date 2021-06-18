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
            UIView.animate(withDuration: 2, animations: {
                self.guidanceView.alpha = 0.0
            })
            
            self.guidanceLabel.text = label
            
            UIView.animate(withDuration: 2, animations: {
                self.guidanceView.alpha = 1.0
            })
        }
    }
    
    func disappearGuidanceLabel() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 2, animations: {
                self.guidanceView.alpha = 0.0
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2, animations: {
            self.guidanceView.alpha = 1.0
        })
    }
}
