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
var resultImage:SKSpriteNode!
let label = SKLabelNode(text:"Continue?")
let yes = SKLabelNode(text:"Yes")
let no = SKLabelNode(text:"No")
var backGround:[SKSpriteNode] = []
extension SKLabelNode{
    class func createScoreLabel(x:Int,y:Int) ->SKLabelNode{
        let node = SKLabelNode(fontNamed: "Zapfino")
        node.position=CGPoint(x:x,y:y)
        node.fontSize=50
        node.horizontalAlignmentMode = .right
        node.fontColor = UIColor.white
        return node
    }
}
class GameScene: SKScene {
    let gameLayer = SKNode()
    let stoneLayer = SKNode()
    var diskNodes = board<SKSpriteNode>(rows: BoardSize, columns: BoardSize)
    var boardState:Board!
    var nextColor:CellState!
    let blackScoreLabel = SKLabelNode.createScoreLabel(x:300 , y: -500)
    let whiteScoreLabel = SKLabelNode.createScoreLabel(x:300, y: -600)
    var switchTurnHandler:(() -> ())?
    var gameResultLayer:SKNode?
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
        self.addChild(self.blackScoreLabel)
        self.addChild(self.whiteScoreLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches{
            let location = touch.location(in:self)
            if self.atPoint(location) == yes{
                gameRestart()
                label.removeFromParent()
                yes.removeFromParent()
                no.removeFromParent()
                let count = backGround.count
                for i in 0..<count{
                    backGround[i].removeFromParent()
                }
                backGround.removeAll()
            }
            if let (row,column) = self.convertPointOnBoard(point:location){
                let move = Move(color:self.nextColor,row:row,column:column)
                if move.canPlace(cells:self.boardState.cells){
                    self.boardState.makeMove(move: move)
                    self.updateDiskNodes()
                    if self.boardState.hasGameFinished(){
                        self.showGameResult()
                    }
                    self.nextColor = self.nextColor.opponent
                    if self.boardState.existsValidMove(color: nextColor){
                        
                    }else{
                        self.nextColor = self.nextColor.opponent
                    }
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
        self.blackScoreLabel.text = String(self.boardState.countCells(state: .Black))
        self.whiteScoreLabel.text = String(self.boardState.countCells(state: .White))
        
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
                      // print(boardState)
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
    func showGameResult(){
        let black = self.boardState.countCells(state: .Black)
        let white = self.boardState.countCells(state: .White)
        if white<black{
            resultImage = SKSpriteNode(imageNamed:"win_black")
        }else if white>black{
            resultImage = SKSpriteNode(imageNamed:"win_white")
        }else{
            resultImage = SKSpriteNode(imageNamed:"draw")
        }
        let sizeRatio = self.size.width/resultImage.frame.width
        let imageheight = resultImage.size.height*sizeRatio
        resultImage.size=CGSize(width: self.size.width, height: imageheight)
        self.addChild(resultImage)

        label.position=CGPoint(x:0,y:-300)
        label.color = UIColor.black
        label.fontColor = UIColor.white
        label.fontSize = 50
        label.fontName = "Zapfino"
        label.zPosition=1
        addChild(label)
        yes.position=CGPoint(x:0,y:-400)
        yes.color = UIColor.black
        yes.fontColor = UIColor.white
        yes.fontSize = 50
        yes.fontName = "Zapfino"
        yes.zPosition=1
        addChild(yes)
        no.position=CGPoint(x:0,y:-500)
        no.color = UIColor.black
        no.fontColor = UIColor.white
        no.fontSize = 50
        no.fontName = "Zapfino"
        no.zPosition=1
        addChild(no)
        for i in 1...3{
            if i==1{
                let tmp = SKSpriteNode(imageNamed: "spriteBack")
                tmp.color = UIColor.black
                tmp.position = CGPoint(x:0,y:label.position.y+30)
                tmp.size = CGSize(width:label.frame.width,height:label.frame.height*1.5)
                tmp.colorBlendFactor=1
                backGround.append(tmp)
                addChild(backGround[0])
            }else if i==2{
                let tmp = SKSpriteNode(imageNamed: "spriteBack")
                tmp.color = UIColor.black
                tmp.position = CGPoint(x:0,y:yes.position.y+30)
                tmp.size = CGSize(width:yes.frame.width,height:yes.frame.height*1.5)
                tmp.colorBlendFactor=1
                backGround.append(tmp)
                addChild(backGround[1])
            }else{
                let tmp = SKSpriteNode(imageNamed: "spriteBack")
                tmp.color = UIColor.black
                tmp.position = CGPoint(x:0,y:no.position.y+30)
                tmp.size = CGSize(width:no.frame.width,height:no.frame.height*1.5)
                tmp.colorBlendFactor=1
                backGround.append(tmp)
                addChild(backGround[2])
            }
            
        }
    }
    func gameRestart(){
        resultImage.removeFromParent()
        for row in 0..<BoardSize{
            for column in 0..<BoardSize{
                if let stoneNode = self.diskNodes[row,column]{
                    stoneNode.removeFromParent()
                    self.diskNodes[row,column] = nil
                }
            }
        }
        self.initBoard()
    }
}
