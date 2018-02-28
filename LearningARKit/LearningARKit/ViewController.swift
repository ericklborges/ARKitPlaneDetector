//
//  ViewController.swift
//  LearningARKit
//
//  Created by Erick Borges on 28/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    // MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - Properties
    let planes = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup
        setupSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK - Setup
    func setupScene(){
        self.sceneView.delegate = self
        self.sceneView.showsStatistics = true
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        let scene = SCNScene()
        self.sceneView.scene = scene
    }
    
    func setupSession(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }

    // MARK: - ARSCNViewDelegate
    // Add Node
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Place content only for anchors found by plane detection.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let plane = Plane(with: planeAnchor)
        self.planes.setObject(plane, forKey: planeAnchor.identifier as NSCopying)
        
        node.addChildNode(plane)
    }
    
    // Update Node
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let planeNode = self.planes.object(forKey: planeAnchor.identifier) as? Plane
            else { return }
        
        planeNode.update(with: planeAnchor)
    }
    
    // Remove Node
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        self.planes.removeObject(forKey: planeAnchor.identifier)
    }
}








