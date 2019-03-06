//
//  Mov.swift
//  reverse
//
//

import Foundation
enum line:Int{
    case BackWard = -1,Hold,Forword
    static let allValues:[line]=[.BackWard,.Hold,.Forword]
}
typealias Direction = (vertical:line,horizonal:line)
class Move{
    let color:CellState
    let row:Int
    let column:Int
    
    init(color:CellState,row:Int,column:Int){
        self.color = color
        self.row = row
        self.column = column
    }
    func countFlippabeDisks(direction:Direction,cells:board<CellState>)->Int{//ひっくり返せる石の数を返り値として出力する
        let y = direction.vertical.rawValue
        let x = direction.horizonal.rawValue
        var opponent = self.color.opponent
        var count = 1
        while(cells[self.row+count*y,self.column+count*x] == opponent){
            count += 1
        }
        if(cells[self.row+count*y,self.column+count*x] == self.color){
            return count-1
        }else{
            return 0
        }
    }
    func canPlace(cells:board<CellState>) -> Bool{
        if let state = cells[self.row,self.column]{
            if state != .Empty{
                return false
            }
        }
        for vertical in line.allValues{
            for horizonal in line.allValues{
                if vertical == .Hold && horizonal == .Hold{
                    continue
                }
                if 0<self.countFlippabeDisks(direction: (vertical,horizonal), cells: cells){
                    return true
                }
            }
        }
        return false
    }
}
