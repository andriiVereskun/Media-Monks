//
//  FunctionalComposition.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator • : CompositionPrecedence


public func •<A, B, C>(lhs: @escaping (A) -> B, rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}

