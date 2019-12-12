//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // Background music player
    var backgroundMusic: AVAudioPlayer?
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Set the background colour
        self.backgroundColor = .black
        
        // Get a reference to the mp3 file in the app bundle
        let backgroundMusicFilePath = Bundle.main.path(forResource: "sleigh-bells-excerpt.mp3", ofType: nil)!
        
        // Convert the file path string to a URL (Uniform Resource Locator)
        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
        
        // Attempt to open and play the file at the given URL
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
            backgroundMusic?.play()
        } catch {
            // Do nothing if the sound file could not be played
        }
        //adding background
        let background = SKSpriteNode(imageNamed: "Background")
        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -10
        self.addChild(background)
        
        let ground = SKSpriteNode(imageNamed: "snow terrain")
        ground.scale(to: CGSize(width: self.size.width, height: 100))
        ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.size)
        ground.position = CGPoint(x: size.width/2, y: 50)
        ground.zPosition = 10
        ground.physicsBody?.isDynamic = false
        addChild(ground)
        
        let snowman = SKSpriteNode(imageNamed: "Snowman")
        snowman.scale(to: CGSize(width: snowman.size.width / 3, height: snowman.size.height / 3))
        snowman.physicsBody = SKPhysicsBody(texture: snowman.texture!, size: snowman.size)
        snowman.position = CGPoint(x: 600, y: 100)
        snowman.zPosition = 2
        snowman.physicsBody?.allowsRotation = false
        addChild(snowman)
        let jump = SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.applyForce(CGVector(dx: 0, dy: 3000), duration: 0.1)]))
        snowman.run(jump)
        
        
        let arm = SKSpriteNode(imageNamed: "Stick Arm")
        arm.anchorPoint = CGPoint(x: 1, y: 0.5)
        arm.run(SKAction.scale(by: 0.025, duration: 0))
        arm.position = CGPoint(x: snowman.position.x + 20, y: snowman.position.y + 65)
        arm.zPosition = 3
        addChild(arm)
        let spin = SKAction.repeatForever(SKAction.rotate(byAngle: -360, duration: 1))
        arm.run(spin)
        let trackingSnowmanMovement = SKAction.repeatForever(SKAction.run {
                   arm.position = CGPoint(x: snowman.position.x + 20, y: snowman.position.y + 65)
               })
        arm.run(trackingSnowmanMovement)
        
        let backArm = SKSpriteNode(imageNamed: "Stick Arm")
        backArm.anchorPoint = CGPoint(x: 1, y: 0.5)
        backArm.run(SKAction.scale(by: 0.025, duration: 0))
        backArm.position = CGPoint(x: snowman.position.x - 30, y: snowman.position.y + 80)
        backArm.zPosition = 1
        addChild(backArm)
        let backSpin = SKAction.sequence([SKAction.wait(forDuration: 0.5), spin])
        backArm.run(backSpin)
        
        view.showsPhysics = true
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
