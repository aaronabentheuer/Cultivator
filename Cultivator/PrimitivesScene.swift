//
//  PrimitivesScene.swift
//  SceneKitTutorial1
//
//  Created by Silviu Pop on 10/23/14.
//  Copyright (c) 2014 We Heart Swift. All rights reserved.
//

import SceneKit

class PrimitivesScene: SCNScene {

    override init() {
        super.init()
        
        var sphereGeometry = SCNSphere(radius: 1.0)
        var sphereNode = SCNNode(geometry: sphereGeometry)
        self.rootNode.addChildNode(sphereNode)
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
