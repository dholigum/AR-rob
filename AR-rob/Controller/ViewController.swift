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
    
    var lastNode: SCNNode!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guidanceView.layer.cornerRadius = 24.5
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        sceneView.automaticallyUpdatesLighting = true
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 8
            print("Images Successfully Added")
            
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            if imageAnchor.referenceImage.name == "glucose" {
                
                let planeNodeEevee = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeEevee, name: "glucose", attacker: BodyType.Glucose.rawValue, target: BodyType.GlucoseMachine.rawValue)
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        pokeNode.name = "glucose"
                        pokeNode.eulerAngles.x = .pi/4
                        planeNodeEevee.addChildNode(pokeNode)
                        
                        node.addChildNode(planeNodeEevee)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "mesinGlukosa"{
                
                let planeNodeMdri = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeMdri, name: "glucoseMachine", category: BodyType.GlucoseMachine.rawValue)
//                setAttackerPhysics(node: planeNodeMdri, name: "glucoseMachine", attacker: BodyType.GlucoseMachine.rawValue, target: BodyType.Result.rawValue)

                let sphere = SCNBox(width: 0.05, height: 0.02, length: 0.05, chamferRadius: 0)
                sphere.firstMaterial?.diffuse.contents = UIColor.blue

                let sphereNode = SCNNode(geometry: sphere)
                sphereNode.position = SCNVector3(0, 0, 0.03)
                sphereNode.name = "glucoseMachine"
                sphereNode.eulerAngles.x = .pi/4
                planeNodeMdri.addChildNode(sphereNode)
                
                node.addChildNode(planeNodeMdri)

            }
            
            if imageAnchor.referenceImage.name == "hasil" {
                
                let planeNodeHasil = generatePlane(imageAnchor)
//                setBasicPhysics(node: planeNodeHasil, name: "Result", category: BodyType.Result.rawValue)
                setAttackerPhysics(node: planeNodeHasil, name: "hasil", attacker: BodyType.Result.rawValue, target: BodyType.GlucoseMachine.rawValue)

//                let box = SCNBox(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0)
//
//                let material = SCNMaterial()
//                material.diffuse.contents = UIColor.red
//
//                box.materials = [material]
//
//                let boxNode = SCNNode(geometry: box)
//                boxNode.position = SCNVector3(0, 0, 0.03)
//
//                planeNodeKTM.addChildNode(boxNode)
                
                node.addChildNode(planeNodeHasil)

            }
        }
        
        return node
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "onboardView") as! OnboardViewController
        
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: true, completion: nil)

    }
    
    func generatePlane(_ imageAnchor: ARImageAnchor) -> SCNNode {
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 4
        planeNode.position = SCNVector3(0, 0, -0.015)
        
        return planeNode
    }
    
}
