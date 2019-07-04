//
//  SceneViewController.swift
//  Swifty_protein
//
//  Created by Victor MARTINS on 4/30/19.
//  Copyright © 2019 Victor MARTINS. All rights reserved.
//

import UIKit
import SceneKit
import CoreGraphics

class SceneViewController: UIViewController {


    var molecule = SCNNode()
    var isActiveHydrogens = false
    var allAtoms: [Int:Atoms] = [:]
    var isSquare : Bool = false
    var modelActif = ModelList.BS
    var lvlAntialiasing = SCNAntialiasingMode.none
    
    var name : String = ""
    var contentPDB : [String] = [] {
        didSet {
            if contentPDB.count != 0 {
                DispatchQueue.main.async {
                    self.parseScene(content: self.contentPDB)
                    self.sceneSetup(scene: SCNScene())
                }
            }
        }
    }
    @IBOutlet weak var SCNView: SCNView!{
        willSet{
            newValue.allowsCameraControl = true
        }
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let renderer = UIGraphicsImageRenderer(size: SCNView.bounds.size)
        let image = renderer.image { ctx in
            SCNView.drawHierarchy(in: SCNView.bounds, afterScreenUpdates: false)
        }
        
        let activityVC : UIActivityViewController = UIActivityViewController(
            activityItems: [image], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func sceneSetup(scene: SCNScene) {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.65, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = (allAtoms.values.first?.position!)! - SCNVector3Make(-20, -20 ,-20)
        cameraNode.look(at: (allAtoms.values.first?.position!)!)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(molecule)
        scene.background.contents = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        if self.SCNView != nil {
            self.SCNView.antialiasingMode = self.lvlAntialiasing
            self.SCNView.allowsCameraControl = true
            self.SCNView.autoenablesDefaultLighting = true
            self.SCNView.scene = scene
            self.SCNView.contentScaleFactor = 1
//            self.SCNView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:))))
        }
    }
    
    func createAtom(_ subContents: [String]) {
        let atom = Atoms(isSquare: self.isSquare, id: subContents[2])
        switch subContents.last!.uppercased() {
        case "C":
            atom.carbon()
        case "F":
            atom.fluorine()
        case "O":
            atom.oxygen()
        case "H":
            if self.isActiveHydrogens == false { return }
            atom.hydrogen()
        case "N":
            atom.nitrogen()
        case "F":
            atom.fluorine()
        case "CL":
            atom.chlorine()
        case "BR":
            atom.bromine()
        case "I":
            atom.iodine()
        case "HE", "NE", "AR", "XE", "KR":
            atom.nobleGases()
        case "P":
            atom.phosphorus()
        case "S":
            atom.sulfur()
        case "B":
            atom.boron()
        case "LI", "NA", "K", "RB", "CS", "FR":
            atom.alkaliMetals()
        case "BE", "MG", "CA", "SR", "BA", "RA":
            atom.alkalineEarthMetals()
        case "TI":
            atom.titanium()
        case "FE":
            atom.iron()
        default:
            atom.other()
        }
        let node = SCNNode(geometry: atom.atom)
        node.position = SCNVector3Make(Float(subContents[6])!,Float(subContents[7])!,Float(subContents[8])!)
        atom.position = node.position
        self.allAtoms[Int(subContents[1])!] = atom
        self.molecule.addChildNode(node)
    }
    
    func drawLine(_ subContents: [String]) {
        var copy = subContents
        let fromIndex = Int(copy[1])!
        if let from = allAtoms[fromIndex] {
            copy.removeFirst(2)
            let listIndex = copy.map({ Int($0)! })
            for index in listIndex {
                if index < fromIndex {
                    if let to = allAtoms[index] {
                        line(fromAtom: from, toAtom: to)
                    }
                }
            }
        }
    }
    
        func line(fromAtom : Atoms, toAtom : Atoms) {
            let from = fromAtom.position!, to = toAtom.position!
            let vector = to - from, length = (vector.length() / 2)
            let cylinders = [SCNCylinder(radius: 0.1, height: CGFloat(length)), SCNCylinder(radius: 0.1, height: CGFloat(length))]
            cylinders[0].radialSegmentCount = 10
            cylinders[1].radialSegmentCount = 10
            cylinders[0].firstMaterial?.diffuse.contents = fromAtom.atom?.firstMaterial!.diffuse.contents
            cylinders[1].firstMaterial?.diffuse.contents = toAtom.atom?.firstMaterial!.diffuse.contents
            let node = SCNNode(geometry: cylinders[0])
            let node2 = SCNNode(geometry: cylinders[1])
            let half = (to + from) / 2
            node.position = (from + half) / 2
            node2.position = (to + half) / 2
            node.eulerAngles = SCNVector3Make(Float(Double.pi/2), acos((half.z-from.z)/Float(length)), atan2((half.y-from.y), (half.x-from.x)))
            node2.eulerAngles = SCNVector3Make(Float(Double.pi/2), acos((to.z-half.z)/Float(length)), atan2((to.y-half.y), (to.x-half.x)))
            self.molecule.addChildNode(node)
            self.molecule.addChildNode(node2)
        }
    
    func parseScene(content: [String]) {
        for line in content {
            var subContents = line.components(separatedBy: " ").filter({ $0 != "" })
            if subContents.count != 0 {
                switch subContents[0] {
                case "ATOM":
                    print(subContents)
                    self.createAtom(subContents)
                case "CONECT":
                    if modelActif == ModelList.BS {
                        self.drawLine(subContents)
                    }
                default:
                    break
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

enum ModelList : Int {
    case BS, SQUARE
}

extension SCNVector3 {
    public func length() -> CGFloat {
        return CGFloat(sqrt(x*x + y*y + z*z))
    }
    
    static public func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
    }
    
    static public func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }
    
    static public func / (vector: SCNVector3, scalar: CGFloat) -> SCNVector3 {
        return SCNVector3(x: vector.x / Float(scalar), y: vector.y / Float(scalar), z: vector.z / Float(scalar))
    }
    
    static public func == (left: SCNVector3, right: SCNVector3) -> Bool {
        return (left.x == right.x && left.y == right.y && left.z == right.z) ? true : false
    }
}
