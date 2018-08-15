//
//  ExperimentScene.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 8/11/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import SpriteKit

class ExperimentScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let backgroundSprite = SKSpriteNode(imageNamed: "graph_paper.jpg")
        backgroundSprite.size = size
        backgroundSprite.position = .zero
        backgroundSprite.zPosition = -100// place way behind any other sprite
        backgroundSprite.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(backgroundSprite)
    }
}
