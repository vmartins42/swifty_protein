//
//  Atoms.swift
//  Swifty_protein
//
//  Created by Victor MARTINS on 6/26/19.
//  Copyright © 2019 Victor MARTINS. All rights reserved.
//

import Foundation

import SceneKit

class Atoms {
    var atom : SCNGeometry?
    var position : SCNVector3?
    var isSquare : Bool
    var id : String
    
    init (isSquare: Bool = false, id: String) {
        self.isSquare = isSquare
        self.id = id
    }
    
    func selectGeometry(_ select: Bool) -> SCNGeometry {
        let atom = select == true ? SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.2) : SCNSphere(radius: 0.4)
        return atom
    }
    
    func hydrogen() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor.white
    }
    
    func carbon() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.30, green:0.30, blue:0.30, alpha:1.0)
    }
    
    func nitrogen() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.50, green:0.54, blue:1.00, alpha:1.0)
    }
    
    func oxygen() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:1.00, green:0.13, blue:0.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:1.00, green:0.76, blue:0.73, alpha:1.0)
    }
    
    func fluorine() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.50, green:1.00, blue:0.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.72, green:1.00, blue:0.45, alpha:1.0)
    }
    
    func chlorine() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.50, green:1.00, blue:0.00, alpha:1.0)
    }
    
    func bromine() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.60, green:0.13, blue:0.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.59, green:0.44, blue:0.40, alpha:1.0)
    }
    
    func iodine() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.40, green:0.00, blue:0.73, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.69, green:0.33, blue:0.98, alpha:1.0)
    }
    
    func nobleGases() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.00, green:1.00, blue:1.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.56, green:1.00, blue:1.00, alpha:1.0)
    }
    
    func phosphorus() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:1.00, green:0.80, blue:0.51, alpha:1.0)
    }
    
    func sulfur() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:1.00, green:0.90, blue:0.13, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:1.00, green:0.95, blue:0.53, alpha:1.0)
    }
    
    func boron() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:1.00, green:0.67, blue:0.47, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:1.00, green:0.81, blue:0.70, alpha:1.0)
    }
    
    func alkaliMetals() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.78, green:0.59, blue:1.00, alpha:1.0)
    }
    
    func alkalineEarthMetals() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.16, green:0.94, blue:0.16, alpha:1.0)
    }
    
    func titanium() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.77, green:0.77, blue:0.77, alpha:1.0)
    }
    
    func iron() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.87, green:0.47, blue:0.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.98, green:0.75, blue:0.48, alpha:1.0)
    }
    
    func other() {
        self.atom = selectGeometry(self.isSquare)
        self.atom?.firstMaterial!.diffuse.contents = UIColor(red:0.87, green:0.47, blue:1.00, alpha:1.0)
        self.atom?.firstMaterial!.specular.contents = UIColor(red:0.91, green:0.67, blue:1.00, alpha:1.0)
    }
}
