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
    var skDone: Bool = false
    
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
            
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            if imageAnchor.referenceImage.name == "glucose" {
                
                let planeNodeGlucose = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeGlucose, name: "glucose", attacker: BodyType.Input.rawValue, target: BodyType.GlucoseMachine.rawValue)
                if let glucoseScene = SCNScene(named: "art.scnassets/glukosa.scn") {
                    
                    if let glucoseNode = glucoseScene.rootNode.childNodes.first {
                        glucoseNode.name = "glucose"
                        glucoseNode.eulerAngles.x = .pi/4
                        glucoseNode.position = SCNVector3(0, 0, 0)
                        planeNodeGlucose.addChildNode(glucoseNode)
                        
                        node.addChildNode(planeNodeGlucose)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "mesinGlikolisis"{
                            
                let planeNodeMdri = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeMdri, name: "glucoseMachine", category: BodyType.GlucoseMachine.rawValue)

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
                setAttackerPhysics(node: planeNodeHasil, name: "hasil", attacker: BodyType.Result.rawValue, target: BodyType.GlucoseMachine.rawValue)
                let resultNode = createTransparentObject()
                resultNode.name = "hasil"
                planeNodeHasil.addChildNode(resultNode)
                node.addChildNode(planeNodeHasil)
            }
            
            if imageAnchor.referenceImage.name == "storage" {
                let planeNodeStorage = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeStorage, name: "storage", attacker: BodyType.Storage.rawValue, target: BodyType.Result.rawValue)
                let storageNode = createTransparentObject()
                storageNode.name = "storage"
                planeNodeStorage.addChildNode(storageNode)
                node.addChildNode(planeNodeStorage)
            }
            
            if imageAnchor.referenceImage.name == "packaging" {
                let planeNodePackaging = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodePackaging, name: "packaging", attacker: BodyType.Packaging.rawValue, target: BodyType.Result.rawValue)
                let packagingNode = createTransparentObject()
                packagingNode.name = "packaging"
                planeNodePackaging.addChildNode(planeNodePackaging)
                node.addChildNode(planeNodePackaging)
            }
            
            if imageAnchor.referenceImage.name == "mesinDO" {
                let planeNodeDO = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeDO, name: "mesinDO", category: BodyType.DOMachine.rawValue)
                
                let cube = SCNBox(width: 0.05, height: 0.02, length: 0.05, chamferRadius: 0)
                cube.firstMaterial?.diffuse.contents = UIColor.blue

                let sphereNode = SCNNode(geometry: cube)
                sphereNode.position = SCNVector3(0, 0, 0.03)
                sphereNode.name = "mesinDO"
                sphereNode.eulerAngles.x = .pi/4
                planeNodeDO.addChildNode(sphereNode)
                
                node.addChildNode(planeNodeDO)
                
            }
            
            if imageAnchor.referenceImage.name == "mesinSK" {
                let planeNodeSK = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeSK, name: "mesinSK", attacker: BodyType.SKMachine.rawValue, target: BodyType.Result.rawValue)
                
                let cube = SCNBox(width: 0.05, height: 0.02, length: 0.05, chamferRadius: 0)
                cube.firstMaterial?.diffuse.contents = UIColor.blue

                let sphereNode = SCNNode(geometry: cube)
                sphereNode.position = SCNVector3(0, 0, 0.03)
                sphereNode.name = "mesinSK"
                sphereNode.eulerAngles.x = .pi/4
                planeNodeSK.addChildNode(sphereNode)
                
                node.addChildNode(planeNodeSK)
                
            }
            
            if imageAnchor.referenceImage.name == "mesinTE" {
                let planeNodeTE = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeTE, name: "mesinTE", attacker: BodyType.TEMachine.rawValue, target: BodyType.Result.rawValue)
                let cube = SCNBox(width: 0.05, height: 0.02, length: 0.05, chamferRadius: 0)
                cube.firstMaterial?.diffuse.contents = UIColor.blue

                let sphereNode = SCNNode(geometry: cube)
                sphereNode.position = SCNVector3(0, 0, 0.03)
                sphereNode.name = "mesinTE"
                sphereNode.eulerAngles.x = .pi/4
                planeNodeTE.addChildNode(sphereNode)
                
                node.addChildNode(planeNodeTE)
                
            }
            
        }
        
        return node
    }
    
    func createTransparentObject() -> SCNNode{
            let box = SCNBox(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor(hexaString: "#ffffff", alpha: 0)
            box.materials = [material]
            let boxNode = SCNNode(geometry: box)
            boxNode.position = SCNVector3(0, 0, 0.03)
            
            return boxNode
        }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        let onboardStoryboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardView = onboardStoryboard.instantiateViewController(identifier: "onboardView") as! OnboardViewController
        
        onboardView.modalPresentationStyle = .fullScreen
        self.present(onboardView, animated: true, completion: nil)

    }
    
    func generatePlane(_ imageAnchor: ARImageAnchor) -> SCNNode {
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width * 1.15, height: imageAnchor.referenceImage.physicalSize.height)
        
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.6)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 4
        planeNode.position = SCNVector3(0, 0, -0.015)
        
        return planeNode
    }
    
}
