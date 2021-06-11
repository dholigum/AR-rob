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
    case Glucose = 1
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
        var child: SCNNode!
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
            
            let boxx = SCNBox(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0)
            let mtr = SCNMaterial()
            mtr.diffuse.contents = UIColor.red
            boxx.materials = [mtr]
            let boxNode = SCNNode(geometry: boxx)
            boxNode.position = SCNVector3(0, 0.05, 0.03)
            
            material.diffuse.contents = UIColor(hexaString: "#ffffff", alpha: 1.0)

            let resultChild = attackerNode.childNode(withName: "hasil", recursively: false)
            resultChild?.geometry?.materials = [material]
            boxNode.name = "ATP"
            attackerNode.addChildNode(boxNode)
            print(contactNode.name!)
            if contactNode.physicsBody?.categoryBitMask == BodyType.Storage.rawValue {
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Storage.rawValue
            }
            else if contactNode.physicsBody?.categoryBitMask == BodyType.Packaging.rawValue {
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Packaging.rawValue
            }
            
            
        case BodyType.Glucose.rawValue:
            child = lastNode.childNode(withName: "\(lastNode.name!)", recursively: false)

            child.geometry?.materials = [material]

            attackerNode.childNode(withName: "\(attackerNode.name!)", recursively: false)?.runAction(removeAction)
        case BodyType.Storage.rawValue:
            
            moveChilds(node: attackerNode, isATP: false)
            
        case BodyType.Packaging.rawValue:
            moveChilds(node: attackerNode, isATP: true)
        default:
            return
        }
    }
    
    func moveChilds(node: SCNNode ,isATP: Bool) {
        
        var selectedChilds = [SCNNode]()
        
        if isATP {
            for child in lastNode.childNodes {
                if child.name == "ATP" {
                    selectedChilds.append(child)
                }
            }
        }
        else {
            for child in lastNode.childNodes {
                if child.name != "ATP" {
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
        
        case BodyType.Glucose.rawValue, BodyType.Result.rawValue, BodyType.Storage.rawValue, BodyType.Packaging.rawValue:
            if contact.nodeB.physicsBody?.categoryBitMask != BodyType.Glucose.rawValue {
                contactNode = contact.nodeB
                attackerNode = contact.nodeA
            }
            else {
                contactNode = contact.nodeA
                attackerNode = contact.nodeB
            }
            
        default:
            contactNode = contact.nodeA
            attackerNode = contact.nodeB
        }
        
        return (contactNode, attackerNode)
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
