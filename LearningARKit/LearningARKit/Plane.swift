//
//  Plane.swift
//  LearningARKit
//
//  Created by Erick Borges on 28/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class Plane: SCNNode {

    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(with anchor: ARPlaneAnchor) {
        super.init()
        self.anchor = anchor
        
        let width = CGFloat(anchor.extent.x)
        let heigth = CGFloat(anchor.extent.z)
        self.planeGeometry = SCNPlane(width: width, height: heigth)
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.simdPosition = float3(anchor.center.x, 0, anchor.center.z)
        planeNode.eulerAngles.x = -.pi/2
        planeNode.opacity = 0.5
        
        self.addChildNode(planeNode)
    }
    
    func update(with anchor: ARPlaneAnchor){
        self.simdPosition = float3(anchor.center.x, 0, anchor.center.z)
        
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
