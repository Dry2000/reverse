//
//  Mov.swift
//  reverse
//
//

import Foundation
enum line:Int{
    case BackWard = -1,Hold,Forword
}
typealias Direction = (vertical:line,horizonal:line)
class Move{
    let color:CellState
    let row:Int
    let column:Int
    
    init(color:CellState,row:Int,column:Int){
        self.color=color
        self.row=row
        self.column=column
    }
    func count
}
