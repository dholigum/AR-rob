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
        print("Kena")
        var contactNode: SCNNode!
        if contact.nodeA.name == "glucose" || contact.nodeA.name == "glucoseMachine" {
            contactNode = contact.nodeB
        }
        else {
            contactNode = contact.nodeA
        }
        
        if self.lastNode != nil && self.lastNode == contactNode {
            return
        }
        self.lastNode = contactNode
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        self.lastNode.geometry?.materials = [material]
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
