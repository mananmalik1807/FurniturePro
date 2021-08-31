//
//  ViewController.swift
//  FurniturePro
//
//  Created by Manan Malik on 24/03/20.
//  Copyright © 2020 Manan Malik. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var isFurniturePresent = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        sceneView.showsStatistics = false
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
    }
    
    @IBOutlet var choosePiano: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func createFloor(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let node = SCNNode()
        
        // previously let geometry = SCNPlane(width: 1.0, height: 1.0)
        let geometry =  SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        node.geometry = geometry
        
        //now rotate this plane
        node.eulerAngles.x = -Float.pi / 2
        node.opacity = 0 //1 is white
        
        return node
    }
    
    func createTable(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNScene(named: "art.scnassets/Table/table.scn")!.rootNode.self
        
        node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        return node
    }
    
    func createArmChair(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNScene(named: "art.scnassets/ArmChair/Ligne_Roset_Citta.scn")!.rootNode.self
        
        node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        return node
    }
    
    @IBAction func pressedBarStool(_ sender: Any) {
        
    }
    func createBarStool(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNScene(named: "art.scnassets/BarStool/BarStool.scn")!.rootNode.self
        
        node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        return node
    }
    
    func createEdieLoungeChair(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNScene(named: "art.scnassets/EdieLoungeChair/EdieLoungeChair.scn")!.rootNode.self
        
        node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        return node
    }
    
    func createPiano(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNScene(named: "art.scnassets/Piano/Piano_Bench.scn")!.rootNode.self
        
        node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        return node
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        if(!isFurniturePresent) {
            let floor = createFloor(planeAnchor: planeAnchor)
            node.addChildNode(floor)
            
            let furniture = createTable(planeAnchor: planeAnchor)
            node.addChildNode(furniture)
            
        }
        isFurniturePresent = true;
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor =  anchor as? ARPlaneAnchor
            //            let planeNode = node.childNodes.first,
            //            let plane = planeNode.geometry as? SCNPlane
            else { return }
        //            planeNode.position = SCNVector3(planeAnchor.center.x,0,planeAnchor.center.z)
        //            plane.width = CGFloat(planeAnchor.extent.x)
        //            plane.height = CGFloat(planeAnchor.extent.z)
        for node in node.childNodes{
            node.position = SCNVector3(planeAnchor.center.x,0,planeAnchor.center.z)
            if let plane = node.geometry as? SCNPlane {
                plane.width = CGFloat(planeAnchor.extent.x)
                plane.height = CGFloat(planeAnchor.extent.z)
            }
        }
    }
    
    var menuShowing = false
    @IBAction func openMenu(_ sender: Any) {
        if(menuShowing){
            
        }
    }
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
