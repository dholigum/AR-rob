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
        
        
        if (self.lastNode != nil && self.lastNode == contactNode && (self.firstNode == attackerNode || self.firstNode == contactNode)) || machineState == 5 {
            return
        }
        
        print("\(attackerNode.name!) = \(contactNode.name!)")
        self.lastNode = contactNode
        self.firstNode = attackerNode
        
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
                changeGuidanceLabel("Dekatkan kartu Input kebagian kiri kartu mesin Transport Elektron")
           }
           else {
            
            machineType(target: lastNode, current: attackerNode)
            
           }
            
        case BodyType.Storage.rawValue:
            moveChilds(node: attackerNode, isATP: false)
            changeGuidanceLabel("Dekatkan kartu hasil kebagian kiri kartu Input")
            
            if skDone {
                attackerNode.physicsBody?.contactTestBitMask = BodyType.Input.rawValue
                changeGuidanceLabel("Dekatkan kartu Storange kebagian kiri kartu Input")
            }
        case BodyType.Packaging.rawValue:
            if machineState == 4{
                finalResult()
                machineState = 5
                return
            }
            moveChilds(node: attackerNode, isATP: true)
            for child in attackerNode.childNodes {
                if child.name == "2CO2" && skDone {
                    let COScene = SCNScene(named: "art.scnassets/6CO2.scn")
                    let newCO = COScene?.rootNode.childNodes.first
                    newCO?.name = "6CO2"
                    newCO?.position = SCNVector3(-0.03, 0.01, 0)
                    newCO?.runAction(getRotate())
                    attackerNode.replaceChildNode(child, with: newCO!)
                    child.removeFromParentNode()
                }
                if child.name == "4CO2" && skDone {
                    child.removeFromParentNode()
                }
            }
            changeGuidanceLabel("Dekatkan kartu Storage kebagian kanan kartu Hasil")
            
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
            machineState = 1
            
            if let piruvatScene = SCNScene(named: "art.scnassets/piruvat.scn") {
                if let piruvateNode = piruvatScene.rootNode.childNodes.first {
                    piruvateNode.name = "piruvat"
                    piruvateNode.position = SCNVector3(-0.03, 0, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    piruvateNode.runAction(rotateForever)
                    myNode.addChildNode(piruvateNode)
                }
            }
            
            if let atpScene = SCNScene(named: "art.scnassets/2atp.scn") {
                if let atpNode = atpScene.rootNode.childNodes.first {
                    atpNode.name = "ATP"
                    atpNode.position = SCNVector3(0, 0, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    atpNode.runAction(rotateForever)
                    myNode.addChildNode(atpNode)
                }
            }
            
            if let nadhScene = SCNScene(named: "art.scnassets/2NADH.scn") {
                if let nadhNode = nadhScene.rootNode.childNodes.first {
                    nadhNode.name = "2NADH"
                    nadhNode.position = SCNVector3(0.025, 0, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    nadhNode.runAction(rotateForever)
                    myNode.addChildNode(nadhNode)
                }
            }
            
            changeGuidanceLabel("Geser kartu hasil dan dekatkan kartu Packaging kebagian kiri")
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.DOMachine.rawValue {
            machineState = 2
            
            if let scene = SCNScene(named: "art.scnassets/2asetilKoA.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "koA"
                    sceneNode.position = SCNVector3(0.03, 0, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/2CO2.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "2CO2"
                    sceneNode.position = SCNVector3(0, 0.03, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/2NADH.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "2NADH"
                    sceneNode.position = SCNVector3(-0.025, 0, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            changeGuidanceLabel("Geser kartu hasil dan dekatkan kartu Packaging kebagian kiri")
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.SKMachine.rawValue {
            skDone = true
            
            if let scene = SCNScene(named: "art.scnassets/2FADH2.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "2FADH2"
                    sceneNode.position = SCNVector3(0.03, -0.03, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/4CO2.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "4CO2"
                    sceneNode.position = SCNVector3(0, 0.03, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/6NADH.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "6NADH"
                    sceneNode.position = SCNVector3(-0.025, -0.03, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            changeGuidanceLabel("Geser kartu hasil dan dekatkan kartu Packaging kebagian kiri")
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.TEMachine.rawValue {
            machineState = 4
            if let scene = SCNScene(named: "art.scnassets/6H2O.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "6H2O"
                    sceneNode.position = SCNVector3(0.03, 0, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            if let scene = SCNScene(named: "art.scnassets/34ATP.scn") {
                if let sceneNode = scene.rootNode.childNodes.first {
                    sceneNode.name = "34ATP"
                    sceneNode.position = SCNVector3(0, 0.03, 0)
                    let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                    let rotateForever = SCNAction.repeatForever(rotateAction)
                    sceneNode.runAction(rotateForever)
                    myNode.addChildNode(sceneNode)
                }
            }
            
            changeGuidanceLabel("Dekatkan kartu Hasil ke bagian kanan kartu Packaging")
        }
        
        if targetNode.physicsBody?.categoryBitMask == BodyType.Input.rawValue {
            for child in myNode.childNodes {
                targetNode.addChildNode(child)
            }
            myNode.physicsBody?.contactTestBitMask = BodyType.DOMachine.rawValue
            
            if machineState == 1 {
                changeGuidanceLabel("Dekatkan kartu Input kebagian kiri kartu mesin Dekarboksilasi")
            }
            else if machineState == 2 {
                changeGuidanceLabel("Dekatkan kartu Input kebagian kiri kartu mesin Kreb")
            }
        }
    }
    
    func machineType(target: SCNNode, current: SCNNode) {
        
        switch target.physicsBody?.categoryBitMask {
        case BodyType.GlucoseMachine.rawValue:
            changeGuidanceLabel("Dekatkan kartu hasil kebagian kanan kartu mesin Glikolisis")
            changingMachineStatics(planeNode: planeNodeGlucose, machineScene: &glucoseMachineScene, machineNode: glucoseMachine, assetDir: "art.scnassets/mesinGerak1.scn")
            
        case BodyType.DOMachine.rawValue:
            changeGuidanceLabel("Dekatkan kartu hasil kebagian kanan kartu mesin Dekarboksilasi")
            changingMachineStatics(planeNode: planeNodeDO, machineScene: &doMachineScene, machineNode: doMachine, assetDir: "art.scnassets/mesinGerak3.scn")
        
        case BodyType.SKMachine.rawValue:
            changeGuidanceLabel("Dekatkan kartu hasil kebagian kanan kartu mesin Krebs")
            changingMachineStatics(planeNode: planeNodeKrebs, machineScene: &krebsMachineScene, machineNode: krebsMachine, assetDir: "art.scnassets/mesinGerak2.scn")
            
        case BodyType.TEMachine.rawValue:
            changeGuidanceLabel("Dekatkan kartu hasil kebagian kanan kartu mesin Transport Elektron")
            changingMachineStatics(planeNode: planeNodeTE, machineScene: &teMachineScene, machineNode: teMachine, assetDir: "art.scnassets/mesinGerak4.scn")
            
        default:
            changeGuidanceLabel("Dekatkan kartu Input kebagian kiri kartu mesin Glikolisis")
        }
        
        removeChild(node: current)
    }
    
    func moveChilds(node: SCNNode ,isATP: Bool) {
        
        var selectedChilds = [SCNNode]()
        
        if isATP {
            for child in lastNode.childNodes {
                if child.name == "ATP" || child.name == "2CO2" || child.name == "4CO2" || child.name == "38ATP" || child.name == "6H2O" {
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
        return .sequence([.wait(duration: 0.5), .fadeOut(duration: 0.5), .removeFromParentNode()])
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
    
    func changingMachineStatics(planeNode: SCNNode, machineScene: inout SCNScene, machineNode: SCNNode, assetDir: String){
        
        machineScene = SCNScene(named: assetDir)!
        let gerakMachine = machineScene.rootNode.childNodes.first
        gerakMachine?.name = "gerakMachine"
        gerakMachine?.position = SCNVector3(0, 0, 0)
        planeNode.replaceChildNode(machineNode, with: gerakMachine ?? machineNode)
    }
    
    func finalResult() {
        for child in firstNode.childNodes {
            if child.name == "ATP" {
                child.removeFromParentNode()
            }
        }
        for child in lastNode.childNodes {
            if child.name == "6H2O" {
                child.position = SCNVector3(0.03, 0, 0)
                firstNode.addChildNode(child)
            }
            else {
                child.removeFromParentNode()
            }
        }
        if let atpScene = SCNScene(named: "art.scnassets/38ATP.scn") {
            if let atpNode = atpScene.rootNode.childNodes.first {
                atpNode.name = "38ATP"
                atpNode.position = SCNVector3(0, 0.04, 0)
                let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
                let rotateForever = SCNAction.repeatForever(rotateAction)
                atpNode.runAction(rotateForever)
                firstNode.addChildNode(atpNode)
            }
        }
        changeGuidanceLabel("Lihat hasil akhir respirasi aerob pada kartu packaging")
    }
    func getRotate() -> SCNAction{
        let rotateAction = SCNAction.rotate(by: 360.degreeToRadians(), around: SCNVector3(0, 1, 0), duration: 4)
        let rotateForever = SCNAction.repeatForever(rotateAction)
        return rotateForever
    }
}
