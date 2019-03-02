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
}





