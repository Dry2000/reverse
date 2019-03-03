//
//  GameScene.swift
//  reverse
//


import SpriteKit
import GameplayKit


let SquareHeight:CGFloat = 38.0
let SquareWidth:CGFloat = 38.0
let StoneImageNames = [
    CellState.Black : "black",
    CellState.White : "white",
]
class GameScene: SKScene {
    let gameLayer = SKNode()
    let stoneLayer = SKNode()
    var diskNodes = board<SKSpriteNode>(rows: BoardSize, columns: BoardSize)
    var boardState:Board!
    override func didMove(to view: SKView) {
        super.anchorPoint = CGPoint(x:0.5,y:0.5)
        
        let background=SKSpriteNode(imageNamed:"background")
        background.zPosition = -1
        background.size = self.size
        self.addChild(background)
        let layerPosition = CGPoint(x:-SquareWidth*CGFloat(BoardSize),y:-SquareHeight*CGFloat(BoardSize))
        self.stoneLayer.position = layerPosition
        self.gameLayer.addChild(self.stoneLayer)
       /* let test = SKSpriteNode(imageNamed:"black")
        print(test.position)
        self.stoneLayer.addChild(test)*/
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches{
            let location=touch.location(in:self)
            print(location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    func initBoard(){
        self.boardState = Board()
        self.updateDiskNodes()
    }
    func updateDiskNodes(){
        for row in 0..<BoardSize{
            for column in 0..<BoardSize{
                if let state = self.boardState.cells[row,column]{
                    if let imageName = StoneImageNames[state]{
                        if let prevNode = self.diskNodes[row,column]{
                            if prevNode.userData?["state"] as! Int == state.rawValue{
                                continue
                            }
                            prevNode.removeFromParent()
                        }
                        let newNode = SKSpriteNode(imageNamed: imageName)
                        newNode.userData = ["state":state.rawValue] as NSMutableDictionary
                        newNode.xScale = SquareWidth/newNode.size.width
                        newNode.yScale = SquareHeight/newNode.size.height
                        newNode.position = self.convertPointOnLayer(row: row,column:column)
                        newNode.zPosition = 10000
                        self.stoneLayer.addChild(newNode)
                        print("\(newNode.position),\(newNode.zPosition) \n")
                        self.diskNodes[row,column] = newNode
                        
                    }
                }
            }
        }
    }
    func convertPointOnLayer(row:Int,column:Int)->CGPoint{
        return CGPoint(x:CGFloat(column)*SquareWidth+SquareWidth/2,y:CGFloat(row)*SquareHeight+SquareHeight/2)
    }
}
