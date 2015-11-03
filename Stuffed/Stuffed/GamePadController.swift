//
//  GamePadController.swift
//  Stuffed
//
//  Created by Anjel Villafranco on 10/27/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class GamePadController: UIViewController, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    
    var session: MCSession!
    var advertiser: MCNearbyServiceAdvertiser!
    var myPeerID: MCPeerID = MCPeerID(displayName: "Anjel")
    
    var boardID: MCPeerID?
    
    @IBAction func left(sender: AnyObject) {
            
        sendData(GameData(action: .Move, direction: .Left))
    }
    
    @IBAction func right(sender: AnyObject) {
        

        sendData(GameData(action: .Move, direction: .Right))
        
    }
    
    @IBAction func fire(sender: AnyObject) {
        
        sendData(GameData(action: .Fire))
        
    }
    
    @IBAction func jump(sender: AnyObject) {
        
        sendData(GameData(action: .Jump))
    }
    
    //NS Keyed Archiver
    
    func sendData(gameData: GameData) {
        
        if let bID = boardID{
            
            do {
                
                try session.sendData(gameData.data, toPeers: [bID], withMode: .Reliable)
                
              
                
            } catch {
                
                print(error)
                
            }
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = MCSession(peer: myPeerID)
        session.delegate = self
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["color":"cyan"], serviceType: serviceType)
        
        
        advertiser.delegate = self
        
        advertiser.startAdvertisingPeer()
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        
        
        print("Inviting Peer \(peerID.displayName)")
        
        if peerID.displayName == "Board" {
            
            boardID = peerID
            
            print(peerID)
            
            print("Accept Invite")
            invitationHandler(true,session)
            //advertiser.stopAdvertisingPeer()
            
        }else{
            
            print("Decline Invite")
            invitationHandler(false,session)
        }
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
        let states = ["Not Connected", "Connecting", "Connected"]
        
        let stateName = states[state.rawValue]
        
        print("\(peerID.displayName) " + stateName)
        
        print(session.connectedPeers)
        
    }
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
        print("\(peerID.displayName)")
        
    }
    
    //// BUTTONS
}
