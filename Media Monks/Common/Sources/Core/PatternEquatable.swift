//
//  PatternEquatable.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

precedencegroup NetworkErrorMatchPrecedence {
    associativity: left
    higherThan: BitwiseShiftPrecedence
}

infix operator %= : NetworkErrorMatchPrecedence
infix operator !%= : NetworkErrorMatchPrecedence


public protocol PatternEquatable {
    
    static func %= (lhs: Self, rhs: Self) -> Bool
    
}

extension PatternEquatable {
    
    public static func !%= (lhs: Self, rhs: Self) -> Bool {
        return !(lhs %= rhs)
    }
    
}

