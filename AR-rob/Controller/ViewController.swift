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
            
            if imageAnchor.referenceImage.name == "eevee" {
                
                let planeNodeEevee = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeEevee, name: "glucose", attacker: BodyType.Glucose.rawValue, target: BodyType.GlucoseMachine.rawValue)
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi/2
//                        pokeNode.name = "glc"
                        planeNodeEevee.addChildNode(pokeNode)
                        
                        node.addChildNode(planeNodeEevee)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "oddish" {
                
                let planeNodeOddish = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeOddish, name: "glucoseMachine", category: BodyType.GlucoseMachine.rawValue)
//                setAttackerPhysics(node: planeNodeOddish, name: "glucoseMachine", attacker: BodyType.GlucoseMachine.rawValue, target: BodyType.Result.rawValue)

                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {

                    if let pokeNode = pokeScene.rootNode.childNodes.first {

                        pokeNode.eulerAngles.x = .pi/2

                        planeNodeOddish.addChildNode(pokeNode)
                        
                        node.addChildNode(planeNodeOddish)
                    }
                }
            }

            if imageAnchor.referenceImage.name == "mdri" {
                
                let planeNodeMdri = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeMdri, name: "result", category: BodyType.Result.rawValue)

                let sphere = SCNSphere(radius: 0.03)
                sphere.firstMaterial?.diffuse.contents = UIColor.blue

                let sphereNode = SCNNode(geometry: sphere)
                sphereNode.position = SCNVector3(0, 0, 0.03)

                planeNodeMdri.addChildNode(sphereNode)
                
                node.addChildNode(planeNodeMdri)

            }
            
            if imageAnchor.referenceImage.name == "kateem" {
                
                let planeNodeKTM = generatePlane(imageAnchor)

                let box = SCNBox(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0)
                        
                let material = SCNMaterial()
                material.diffuse.contents = UIColor.red
                        
                box.materials = [material]
                        
                let boxNode = SCNNode(geometry: box)
                boxNode.position = SCNVector3(0, 0, 0.03)

                planeNodeKTM.addChildNode(boxNode)
                
                node.addChildNode(planeNodeKTM)

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
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width * 1.25, height: imageAnchor.referenceImage.physicalSize.height * 1.25)
        
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.8)
        
        let planeNode = SCNNode(geometry: plane)
        
        planeNode.eulerAngles.x = -.pi / 2
        
        return planeNode
    }
    
}
