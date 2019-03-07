//
//  Board.swift
//  reverse
//
//

import Foundation
let BoardSize=8
class Board:CustomStringConvertible{
        var cells:board<CellState>
    init(){
    self.cells=board<CellState>(rows:BoardSize,columns:BoardSize,repeatedValue:.Empty)
        self.cells[3,4] = .Black
        self.cells[4,3] = .Black
        self.cells[3,3] = .White
        self.cells[4,4] = .White
    }
    var description:String{
        var rows=Array<String>()
        for row in 0..<BoardSize{
            var cells=Array<String>()
            for column in 0..<BoardSize{
                if let state=self.cells[row,column]{
                    cells.append(String(state.rawValue))
                }
            }
            var line = cells.joined(separator: " ")
            rows.append(line)
        }
        return rows.reversed().joined(separator:"\n")
    }
    func makeMove(move:Move){
        for vertical in line.allValues{
            for horizonal in line.allValues{
                if vertical == .Hold && horizonal == .Hold{
                    continue
                }
                let direction = (vertical,horizonal)
                let count = move.countFlippabeDisks(direction: direction, cells: self.cells)
                if count > 0 {
                    let y = vertical.rawValue
                    let x = horizonal.rawValue
                    for i in 1...count{
                        self.cells[move.row+i*y,move.column+i*x] = move.color
                    }
                }
            }
        }
    self.cells[move.row,move.column] = move.color
    }
    func countCells(state:CellState)->Int{
        var count = 0
        for row in 0..<BoardSize{
            for column in 0..<BoardSize{
                if self.cells[row,column] == state{
                    count += 1
                }
            }
        }
        return count
    }
    func hasGameFinished() -> Bool{
        return self.existsValidMove(color: .Black) == false && self.existsValidMove(color: .White) == false
    }
    func existsValidMove(color:CellState) -> Bool{
        for row in 0..<BoardSize{
            for column in 0..<BoardSize{
                let move = Move(color: color, row:row, column: column)
                if move.canPlace(cells: self.cells){
                    return true
                }
            }
        }
        return false
    }
}
