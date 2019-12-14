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
        
        let snow = SKEmitterNode(fileNamed: "MyParticle")
        snow?.advanceSimulationTime(10)
        snow?.particlePosition = CGPoint(x: size.width / 2, y: size.height)
        snow?.zPosition = 9
        addChild(snow!)
        snow?.advanceSimulationTime(10)
        
        let message = SKSpriteNode(imageNamed: "merryChristmas")
        message.position = CGPoint(x: 200, y: 400)
        message.zPosition = -8
        addChild(message)
        
        let credits = SKSpriteNode(imageNamed: "credit")
        credits.position = CGPoint(x: 200, y: 280)
        credits.zPosition = -7
        let creditScaleFactor = CGFloat(0.3)
        credits.scale(to: CGSize(width: credits.size.width * creditScaleFactor, height: credits.size.height * creditScaleFactor))
        addChild(credits)
        
        
        let ground = SKSpriteNode(imageNamed: "snow terrain")
        ground.scale(to: CGSize(width: self.size.width * 1.5, height: 100))
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
        snowman.physicsBody?.isResting = true
        snowman.physicsBody?.friction = 1
        addChild(snowman)
        let jump = SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.applyForce(CGVector(dx: 0, dy: 3000), duration: 0.1)]))
        let becomeStill = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run {snowman.physicsBody?.isDynamic = false}])
        snowman.run(becomeStill)
        
        let arm = SKSpriteNode(imageNamed: "Stick Arm")
        arm.anchorPoint = CGPoint(x: 1, y: 0.5)
        arm.run(SKAction.scale(by: 0.025, duration: 0))
        arm.position = CGPoint(x: snowman.position.x + 20, y: snowman.position.y + 65)
        arm.zPosition = 3
        addChild(arm)
        let initialSpin = SKAction.rotate(byAngle: 80, duration: 0.01)
        let spin = SKAction.repeatForever(SKAction.rotate(byAngle: -360, duration: 1))
        let waitThenSpin = SKAction.sequence([initialSpin, SKAction.wait(forDuration: 3), spin])
        arm.run(waitThenSpin)
       
        
        let backArm = SKSpriteNode(imageNamed: "Stick Arm")
        backArm.anchorPoint = CGPoint(x: 1, y: 0.5)
        backArm.run(SKAction.scale(by: 0.025, duration: 0))
        backArm.position = CGPoint(x: snowman.position.x - 30, y: snowman.position.y + 80)
        backArm.zPosition = 1
        addChild(backArm)
        let backSpin = SKAction.sequence([initialSpin, SKAction.wait(forDuration: 3.5), spin])
        backArm.run(backSpin)
        
        view.showsPhysics = false
        
        for x in stride(from: 20, to: 400, by: 50) {
            for y in stride(from: 30, to: 500, by: 50) {
                let icePosition = CGPoint(x: x, y: y)
                createIceCube(atPosition: icePosition)
            }
        }
        
        let waitTime = SKAction.wait(forDuration: 3.0)
        let throwPoint = CGPoint(x: 550, y: 220)
        let actualThrow = SKAction.run {
            self.throwSnowball(throwFrom: throwPoint, withVelocity: CGVector(dx: -100000, dy: CGFloat.random(in: (1...70000))))
        }
        let timedThrows = SKAction.sequence([SKAction.wait(forDuration: 0.25), actualThrow])
        let throwSequence = SKAction.sequence([waitTime, SKAction.repeatForever(timedThrows)])
        self.run(throwSequence)
        
//        let trackingSnowmanMovement = SKAction.repeatForever(SKAction.run {
//                          //arm.position = CGPoint(x: snowman.position.x + 20, y: snowman.position.y + 65)
//                      })
//               arm.run(trackingSnowmanMovement)
//
    }
    
    
    
    func createIceCube(atPosition: CGPoint) {
        let iceCube = SKSpriteNode(imageNamed: "icecube")
        iceCube.position = atPosition
        iceCube.zPosition = 3
        let scaleFactor = CGFloat(0.2)
        iceCube.scale(to: CGSize(width: iceCube.size.width * scaleFactor, height: iceCube.size.height * scaleFactor))
        iceCube.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: iceCube.size.width * 0.9, height: iceCube.size.width * 0.9))
        iceCube.physicsBody?.restitution = 0.1
        iceCube.physicsBody?.friction = 0.2
        iceCube.physicsBody?.mass = 3
        addChild(iceCube)
    }
    
    func throwSnowball(throwFrom: CGPoint, withVelocity: CGVector) {
        let snowball = SKSpriteNode(imageNamed: "Snowball")
        let scaleFactor = CGFloat.random(in: (0.008...0.015))
        snowball.scale(to: CGSize(width: snowball.size.width * scaleFactor, height: snowball.size.height * scaleFactor))
        snowball.physicsBody = SKPhysicsBody(circleOfRadius: snowball.size.width / 2)
        snowball.position = throwFrom
        snowball.zPosition = 8
        snowball.physicsBody?.mass = 8
        addChild(snowball)
        snowball.run(SKAction.sequence([SKAction.wait(forDuration: 0.001), SKAction.applyForce(withVelocity, duration: 0.1)]))
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
