//
//  GameViewController.swift
//  reverse
//


import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let boards=Board()
        print(boards)
        
         let move = Move(color: .Black, row: 3, column: 2)
        var count = move.countFlippabeDisks(direction: (vertical: .Hold, horizonal: .Forword), cells:boards.cells )
        print(count)
        count = move.countFlippabeDisks(direction: (vertical: .Forword, horizonal: .Hold), cells:boards.cells )
        print(count)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
