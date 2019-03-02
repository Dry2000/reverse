//
//  Array.swift
//  reverse
//


import Foundation

struct board<T>{
    let rows:Int
    let columns:Int
    private var array:[T?]
    init(rows:Int,columns:Int,repeatedValue:T? = nil){
        self.rows=rows
        self.columns=columns
        self.array=Array<T?>(repeating:repeatedValue, count: rows*columns)
    }
    subscript(row:Int,column:Int)->T?{
        get{
            if row<0||self.rows<=row||column<0||self.columns<=column{
                return nil
            }
            let index=row*self.columns+column
            return array[index]
        }
        set{
            self.array[row*self.columns+column]=newValue
        }
    }
}
