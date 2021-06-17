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
    @IBOutlet weak var guidanceLabel: UILabel!
    
    var lastNode: SCNNode!
    var skDone: Bool = false
    
    var firstNode : SCNNode!
    
    //komponen Glikolisis
    var planeNodeGlucose: SCNNode!
    var glucoseMachineScene: SCNScene!
    var glucoseMachine: SCNNode!
    var glucoseSphere: SCNNode!
    
    //komponen DO
    var planeNodeDO: SCNNode!
    var doMachineScene: SCNScene!
    var doMachine: SCNNode!
    var doSphere: SCNNode!
    
    //komponenKerbs
    var planeNodeKrebs: SCNNode!
    var krebsMachineScene: SCNScene!
    var krebsMachine: SCNNode!
    var krebsSphere: SCNNode!
    
    //komponenTE
    var planeNodeTE: SCNNode!
    var teMachineScene: SCNScene!
    var teMachine: SCNNode!
    var teSphere: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guidanceView.layer.cornerRadius = 24.5
        guidanceView.alpha = 0.0
        
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
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Arrob Cards", bundle: Bundle.main) {
            
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
            
            if imageAnchor.referenceImage.name == "input" {
                let planeNodeGlucose = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeGlucose, name: "glucose", attacker: BodyType.Input.rawValue, target: BodyType.GlucoseMachine.rawValue)
                if let glucoseScene = SCNScene(named: "art.scnassets/glukosa.scn") {
                    if let glucoseNode = glucoseScene.rootNode.childNodes.first {
                        glucoseNode.name = "glucose"
                        //glucoseNode.eulerAngles.x = .pi/4
                        glucoseNode.position = SCNVector3(0, 0, 0)
                        planeNodeGlucose.addChildNode(glucoseNode)
                        let scaleAction = SCNAction.scale(by: 1.1, duration: 1)
                        let scaleShrink = SCNAction.scale(by: 0.9, duration: 1)
                        let beatAction = SCNAction.sequence([scaleAction,scaleShrink])
                        let beatForever = SCNAction.repeatForever(beatAction)
                        glucoseNode.runAction(beatForever)
                        let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 8)
                        let rotateForever = SCNAction.repeatForever(rotateAction)
                        glucoseNode.runAction(rotateForever)
                        node.addChildNode(planeNodeGlucose)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "engineGlikolisisCard"{
                
                planeNodeGlucose = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeGlucose, name: "glucoseMachine", category: BodyType.GlucoseMachine.rawValue)
                glucoseMachineScene = SCNScene(named: "art.scnassets/mesinStatic1.scn")
                glucoseMachine = glucoseMachineScene.rootNode.childNodes.first
                glucoseMachine.name = "glucose"
                glucoseMachine.position = SCNVector3(0, 0, 0)
                planeNodeGlucose.addChildNode(glucoseMachine)
                node.addChildNode(planeNodeGlucose)
            }
            
            if imageAnchor.referenceImage.name == "hasil" {
                
                let planeNodeHasil = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeHasil, name: "hasil", attacker: BodyType.Result.rawValue, target: BodyType.GlucoseMachine.rawValue)
                let resultNode = createTransparentObject()
                resultNode.name = "hasil"
                planeNodeHasil.addChildNode(resultNode)
                node.addChildNode(planeNodeHasil)
            }
            
            if imageAnchor.referenceImage.name == "storageCard" {
                let planeNodeStorage = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeStorage, name: "storage", attacker: BodyType.Storage.rawValue, target: BodyType.Result.rawValue)
                let storageNode = createTransparentObject()
                storageNode.name = "storage"
                planeNodeStorage.addChildNode(storageNode)
                node.addChildNode(planeNodeStorage)
            }
            
            if imageAnchor.referenceImage.name == "packagingCard" {
                let planeNodePackaging = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodePackaging, name: "packaging", attacker: BodyType.Packaging.rawValue, target: BodyType.Result.rawValue)
                let packagingNode = createTransparentObject()
                packagingNode.name = "packaging"
                planeNodePackaging.addChildNode(planeNodePackaging)
                node.addChildNode(planeNodePackaging)
            }
            
            if imageAnchor.referenceImage.name == "engineDOCard" {
                
                planeNodeDO = generatePlane(imageAnchor)
                setBasicPhysics(node: planeNodeDO, name: "doMachine", category: BodyType.DOMachine.rawValue)
                doMachineScene = SCNScene(named: "art.scnassets/mesinStatic3.scn")
                doMachine = doMachineScene.rootNode.childNodes.first
                doMachine.name = "glucose"
                doMachine.position = SCNVector3(0, 0, 0)
                planeNodeDO.addChildNode(doMachine)
                node.addChildNode(planeNodeDO)
                
            }
            
            if imageAnchor.referenceImage.name == "engineKrebCard" {
                planeNodeKrebs = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeKrebs, name: "krebsMachine", attacker: BodyType.SKMachine.rawValue, target: BodyType.Result.rawValue)
                krebsMachineScene = SCNScene(named: "art.scnassets/mesinStatic2.scn")
                krebsMachine = krebsMachineScene.rootNode.childNodes.first
                krebsMachine.name = "glucose"
                krebsMachine.position = SCNVector3(0, 0, 0)
                planeNodeKrebs.addChildNode(krebsMachine)
                node.addChildNode(planeNodeKrebs)
            }
            
            if imageAnchor.referenceImage.name == "engineTECard" {
                planeNodeTE = generatePlane(imageAnchor)
                setAttackerPhysics(node: planeNodeTE, name: "teMachine", attacker: BodyType.TEMachine.rawValue, target: BodyType.Result.rawValue)
                teMachineScene = SCNScene(named: "art.scnassets/mesinStatic4.scn")
                teMachine = teMachineScene.rootNode.childNodes.first
                teMachine.name = "te"
                teMachine.position = SCNVector3(0, 0, 0)
                planeNodeTE.addChildNode(teMachine)
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
extension Int{
    func degreeToRadians() -> CGFloat{
        return CGFloat(self) * CGFloat.pi / 180.0
    }
}
