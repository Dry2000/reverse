//
//  CellState.swift
//  reverse
//

import Foundation
public enum CellState:Int{
    case Empty=0,Black,White
    
    var opponent:CellState{//ひっくり返す処理の中でどの色に変わるかの指定
        switch self{
        case .Black:
            return .White
        case .White:
            return .Black
        default:
            return self
        }
    }
}
