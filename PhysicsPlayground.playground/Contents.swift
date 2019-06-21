//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit


// Set scene view
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height: 320))

// Set scene
let scene = SKScene(size: CGSize(width: 480, height: 320))

// Set properties
sceneView.showsFPS = true
sceneView.showsPhysics = true
sceneView.presentScene(scene)
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

// Live preview - not working for some reason
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = sceneView

// Generate sprites
let square = SKSpriteNode(imageNamed: "square")
square.name = "shape"
square.position = CGPoint(x: scene.size.width * 0.25,
                          y: scene.size.height * 0.50)
let circle = SKSpriteNode(imageNamed: "circle")
circle.name = "shape"
circle.position = CGPoint(x: scene.size.width * 0.50,
                          y: scene.size.height * 0.50)
let triangle = SKSpriteNode(imageNamed: "triangle")
triangle.name = "shape"
triangle.position = CGPoint(x: scene.size.width * 0.75,
                            y: scene.size.height * 0.50)

// Add sprites to scene
scene.addChild(square)
scene.addChild(circle)
scene.addChild(triangle)

// Add sprites to physics world
circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width/2)
square.physicsBody = SKPhysicsBody(rectangleOf: square.frame.size)

// Example on drawing path for complex sprite shape like a triangle
let trianglePath = CGMutablePath()
trianglePath.move(to: CGPoint(x: -triangle.size.width/2,
                              y: -triangle.size.height/2))
trianglePath.addLine(to: CGPoint(x: triangle.size.width/2,
                                 y: -triangle.size.height/2))
trianglePath.addLine(to: CGPoint(x: 0,
                                 y: triangle.size.height/2))
trianglePath.addLine(to: CGPoint(x: -triangle.size.width/2,
                                 y: -triangle.size.height/2))
triangle.physicsBody = SKPhysicsBody(polygonFrom: trianglePath)

// Example on drawing path for complex sprites like L shape, with alpha mask
let l = SKSpriteNode(imageNamed: "L")
l.name = "shape"
l.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.75)
l.physicsBody = SKPhysicsBody(texture: l.texture!, size: l.size)
scene.addChild(l)

// Spawn particles function
func spawnSand() {
    let sand = SKSpriteNode(imageNamed: "sand")
    
    sand.position = CGPoint(
        x: random(min: 0.0, max: scene.size.width),
        y: scene.size.height - sand.size.height)
    sand.physicsBody = SKPhysicsBody(circleOfRadius: sand.size.width/2)
    sand.name = "sand"
    sand.physicsBody!.restitution = 1.0
    scene.addChild(sand)
}

// delay function defined in helper file
delay(seconds: 2.0) {
    scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    scene.run(
    SKAction.repeat(
        SKAction.sequence([
            SKAction.run(spawnSand),
            SKAction.wait(forDuration: 0.1)
            ]),
        count: 100))
}











