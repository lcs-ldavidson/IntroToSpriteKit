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
        
        let arm = SKSpriteNode(imageNamed: "Stick Arm")
        arm.anchorPoint = CGPoint(x: 1, y: 0.5)

        view.showsPhysics = true
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
