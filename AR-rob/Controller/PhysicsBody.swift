//
//  PhysicsBody.swift
//  AR-rob
//
//  Created by Revarino Putra on 09/06/21.
//

import Foundation
import UIKit
import SceneKit
import ARKit

enum BodyType: Int {
    case Input = 1
    case GlucoseMachine = 2
    case DOMachine = 3
    case SKMachine = 4
    case TEMachine = 5
    case Result = 6
    case Packaging = 7
    case Storage = 8
}

extension ViewController: SCNPhysicsContactDelegate {
    override func viewWillLayoutSubviews() {
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {

        var contactNode: SCNNode!
        var attackerNode: SCNNode!
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        

        let getContact = setContactNode(contact: contact)
        contactNode = getContact.contactNode
        attackerNode = getContact.attackerNode
        print("\(attackerNode.name!) = \(contactNode.name!)")
        
        if self.lastNode != nil && self.lastNode == contactNode && attackerNode.physicsBody?.categoryBitMask != BodyType.Result.rawValue {
            return
        }
        
        self.lastNode = contactNode
        
        switch attackerNode.physicsBody?.categoryBitMask {
        case BodyType.Result.rawValue:
            attackMachine(myNode: attackerNode, targetNode: contactNode)
            
            if contactNode.physicsBody?.categoryBitMask == BodyType.Storage.rawValue {
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Storage.rawValue
            }
            else if contactNode.physicsBody?.categoryBitMask == BodyType.Packaging.rawValue {
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Packaging.rawValue
            }
            
        case BodyType.Input.rawValue:
           if contactNode.physicsBody?.categoryBitMask == BodyType.Result.rawValue {
                contactNode.physicsBody?.contactTestBitMask = BodyType.Input.rawValue
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Result.rawValue
            }
           else if lastNode.physicsBody?.categoryBitMask == BodyType.Storage.rawValue {
                for child in lastNode.childNodes {
                    attackerNode.addChildNode(child)
                }
           }
           else {
                
            guard let child = lastNode.childNode(withName: "\(lastNode.name!)", recursively: false) else {
                return
            }
                child.geometry?.materials = [material]
                removeChild(node: attackerNode)
            }
            
        case BodyType.Storage.rawValue:
            moveChilds(node: attackerNode, isATP: false)
            print(skDone)
            if skDone {
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Input.rawValue
            }
        case BodyType.Packaging.rawValue:
            moveChilds(node: attackerNode, isATP: true)
            for child in attackerNode.childNodes {
                if child.name == "4CO2"{
                    attackerNode.childNode(withName: "2CO2", recursively: false)?.removeFromParentNode()
                }
            }
        case BodyType.SKMachine.rawValue :
            
            if lastNode.physicsBody?.categoryBitMask == BodyType.Input.rawValue {
                lastNode.physicsBody?.contactTestBitMask = BodyType.SKMachine.rawValue
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Result.rawValue
            }
            else {
                lastNode.physicsBody?.contactTestBitMask = BodyType.SKMachine.rawValue
                attackerNode.physicsBody?.contactTestBitMask = 0
            }
        case BodyType.TEMachine.rawValue :
            lastNode.physicsBody?.contactTestBitMask = BodyType.TEMachine.rawValue
            attackerNode.physicsBody?.contactTestBitMask = 0
            
        default:
            return
        }
    }
    
    func attackMachine(myNode: SCNNode, targetNode: SCNNode) {
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.GlucoseMachine.rawValue {
            if let piruvatScene = SCNScene(named: "art.scnassets/piruvat.scn") {
                if let piruvateNode = piruvatScene.rootNode.childNodes.first {
                    piruvateNode.name = "piruvat"
                    piruvateNode.position = SCNVector3(-0.03, 0, 0)
                    myNode.addChildNode(piruvateNode)
                }
            }
            
            if let atpScene = SCNScene(named: "art.scnassets/2atp.scn") {
                if let atpNode = atpScene.rootNode.childNodes.first {
                    atpNode.name = "ATP"
                    atpNode.position = SCNVector3(0, 0, 0)
                    myNode.addChildNode(atpNode)
                }
            }
            
            let box = SCNBox(width: 0.02, height: 0.02, length: 0.02, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.purple
            box.materials = [material]
            let boxNode = SCNNode(geometry: box)
            boxNode.name = "NADH"
            boxNode.position = SCNVector3(0.025, 0, 0)
            myNode.addChildNode(boxNode)
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.DOMachine.rawValue {
            if let scene = SCNScene(named: "art.scnassets/2asetilKoA.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "koA"
                    sceneNode.position = SCNVector3(0.03, 0, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/2CO2.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "2CO2"
                    sceneNode.position = SCNVector3(0, 0.03, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/2NADH.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "2NADH"
                    sceneNode.position = SCNVector3(-0.025, 0, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
        }
        if targetNode.physicsBody?.categoryBitMask == BodyType.Input.rawValue {
            for child in myNode.childNodes {
                targetNode.addChildNode(child)
            }
            myNode.physicsBody?.contactTestBitMask = BodyType.DOMachine.rawValue
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.SKMachine.rawValue {
            skDone = true
            if let scene = SCNScene(named: "art.scnassets/2FADH2.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "2FADH2"
                    sceneNode.position = SCNVector3(0.03, 0, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/4CO2.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "4CO2"
                    sceneNode.position = SCNVector3(0, 0.03, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/6NADH.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "6NADH"
                    sceneNode.position = SCNVector3(-0.025, 0, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.TEMachine.rawValue {
            if let scene = SCNScene(named: "art.scnassets/6H2O.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "6H2O"
                    sceneNode.position = SCNVector3(0.03, 0, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/34ATP.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "34ATP"
                    sceneNode.position = SCNVector3(0, 0.03, 0)
                    myNode.addChildNode(sceneNode)
                }
            }
        }
    }
    
    func moveChilds(node: SCNNode ,isATP: Bool) {
        
        var selectedChilds = [SCNNode]()
        
        if isATP {
            for child in lastNode.childNodes {
                if child.name == "ATP" || child.name == "2CO2" || child.name == "4CO2" {
                    selectedChilds.append(child)
                }
            }
        }
        else {
            for child in lastNode.childNodes {
                if child.name != "ATP" && child.name != "piruvat" && child.name != "koA" && child.name != "2CO2"  && child.name != "4CO2"{
                    selectedChilds.append(child)
                }
            }
        }
        for data in selectedChilds {
            node.addChildNode(data)
        }
    }
    
    func setContactNode(contact: SCNPhysicsContact) -> (contactNode: SCNNode, attackerNode: SCNNode) {
        var contactNode: SCNNode!
        var attackerNode: SCNNode!
        switch contact.nodeA.physicsBody?.categoryBitMask {
        
        case BodyType.Input.rawValue, BodyType.Result.rawValue, BodyType.Storage.rawValue, BodyType.Packaging.rawValue, BodyType.SKMachine.rawValue, BodyType.TEMachine.rawValue:
                contactNode = contact.nodeB
                attackerNode = contact.nodeA
            
        default:
            contactNode = contact.nodeA
            attackerNode = contact.nodeB
        }
        
        return (contactNode, attackerNode)
    }
    
    func removeChild(node: SCNNode) {
        for child in node.childNodes {
            child.runAction(removeAction)
        }
    }

    var removeAction: SCNAction {
        return .sequence([.wait(duration: 1.5), .fadeOut(duration: 1.0), .removeFromParentNode()])
    }
    
    func setAttackerPhysics(node: SCNNode, name: String, attacker: Int, target: Int) {
        setBasicPhysics(node: node, name: name, category: attacker)
        node.physicsBody?.contactTestBitMask = target
    }
    
    func setBasicPhysics(node: SCNNode, name: String, category: Int) {
        node.name = name
        node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        node.physicsBody?.isAffectedByGravity = false
        node.physicsBody?.categoryBitMask = category
    }

}
