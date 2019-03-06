//
//  GameScene.swift
//  reverse
//


import SpriteKit
import GameplayKit

var nodes:CGPoint!
var positions:[SKSpriteNode] = []
var p:SKSpriteNode!
let SquareHeight:CGFloat = 20.0
let SquareWidth:CGFloat = 20.0
let StoneImageNames = [
    CellState.Black : "black",
    CellState.White : "white",
]
class GameScene: SKScene {
    let gameLayer = SKNode()
    let stoneLayer = SKNode()
    var diskNodes = board<SKSpriteNode>(rows: BoardSize, columns: BoardSize)
    var boardState:Board!
    var nextColor:CellState!
    override func didMove(to view: SKView) {
        setposition()
        super.anchorPoint = CGPoint(x:0.5,y:0.5)
        
        let background=SKSpriteNode(imageNamed:"background")
        background.zPosition = -1
        background.size = self.size
        self.addChild(background)
        let layerPosition = CGPoint(x:-SquareWidth*CGFloat(BoardSize),y:-SquareHeight*CGFloat(BoardSize))
        self.stoneLayer.position = layerPosition
        self.gameLayer.addChild(self.stoneLayer)
        let test = SKSpriteNode(imageNamed:"enemy")
        //print(stoneLayer.position ,stoneLayer.zPosition)
        //print(test.position)
      //  self.addChild(test)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches{
            let location = touch.location(in:self)
            if let (row,column) = self.convertPointOnBoard(point:location){
                //print(row,column)
                let move = Move(color:self.nextColor,row:row,column:column)
                if move.canPlace(cells:self.boardState.cells){
                    self.boardState.makeMove(move: move)
                    self.updateDiskNodes()
                    self.nextColor = self.nextColor.opponent
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      /*  for touch:AnyObject in touches{
            let location=touch.location(in:self)
            print(location)
        }*/
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
        self.nextColor = .Black
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
                        newNode.size = CGSize(width: SquareWidth*5, height: SquareHeight*5)
                        newNode.position = self.convertPointOnLayer(row: row,column:column)
                       // newNode.zPosition = 10000
                        self.addChild(newNode)
                       // print("\(newNode.position),\(newNode.zPosition) \n")
                        self.diskNodes[row,column] = newNode
                       print(boardState)
                    }
                }
            }
        }
    }
    func convertPointOnLayer(row:Int,column:Int)->CGPoint{
        var x:Int
        var y:Int
        x = 90*(column-4)+44
        y = 90*(row-4)+64
        return CGPoint(x:x,y:y)
    }
    func convertPointOnBoard(point:CGPoint)->(row:Int,column:Int)?{
        var x:Int
        var y:Int
        var nodes = self.atPoint(point)
        x=Int(nodes.position.x/90)
        y=Int(nodes.position.y/90)
       // print(y,x)
        if x == 0 && point.x<0{
            x = 3
        }else if point.x>0 && x == 0{
            x = 4
        }else if point.x>0{
            x += 4
        }else{
            x += 3
        }
        if y == 0 && point.y<0{
            y = 3
        }else if point.y>0 && y == 0{
            y = 4
        }else if point.y>0{
            y += 4
        }else{
            y += 3
        }
       // print(point,x,y)
        return (row:y,column:x)
    }
    func setposition(){
        for row in 0..<BoardSize{
            for column in 0..<BoardSize{
                    p = SKSpriteNode(imageNamed:"invisible")
                    p.position=CGPoint(x:90*(column-4)+44,y:90*(row-4)+64)
                   // print(p.position)
                    positions.append(p)
                
                self.addChild(p)
            }
        }
    }
}
