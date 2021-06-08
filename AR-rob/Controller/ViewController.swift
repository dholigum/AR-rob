//
//  ViewController.swift
//  AR-rob
//
//  Created by Syahrul Apple Developer BINUS on 08/06/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var guidanceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guidanceView.layer.cornerRadius = 24.5
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "onboardView") as! OnboardViewController
        
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: true, completion: nil)
        
        
    }
    
}
