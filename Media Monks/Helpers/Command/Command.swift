//
//  Command.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/26/21.
//

import Foundation

import Foundation

final public class Command {
    
    private let file: StaticString
    private let function: StaticString
    private let line: Int
    private let id: String
    
    private let action: () -> Void
    
    public init(id: String = "unnamed",
                file: StaticString = #file,
                function: StaticString = #function,
                line: Int = #line,
                action: @escaping () -> Void) {
        
        self.id = id
        self.action = action
        self.function = function
        self.file = file
        self.line = line
    }
    
    public func perform() {
        action()
    }
    
    public static let nop = Command { }
    
    /// Support for Xcode quick look feature.
    @objc
    public func debugQuickLookObject() -> AnyObject? {
        return """
            type: \(String(describing: type(of: self)))
            id: \(id)
            file: \(file)
            function: \(function)
            line: \(line)
            """ as NSString
    }
}

extension Command: Codable {
    
    public convenience init(from decoder: Decoder) throws {
        self.init { }
    }
    
    public func encode(to encoder: Encoder) throws {}
}

final public class CommandWith<T> {
    
    private let action: (T) -> Void
    
    public init(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    public func perform(with value: T) {
        action(value)
    }
    
    public func bind(to value: T) -> Command {
        return Command { self.perform(with: value) }
    }
    
    public static var nop: CommandWith {
        return CommandWith { _ in }
    }
    
    public func dispatched(on queue: DispatchQueue) -> CommandWith {
        return CommandWith { value in
            queue.async {
                self.perform(with: value)
            }
        }
    }
    
    public func then(_ another: CommandWith) -> CommandWith {
        return CommandWith { value in
            self.perform(with: value)
            another.perform(with: value)
        }
    }
}

extension CommandWith: Hashable {
    
    public static func == (lhs: CommandWith<T>, rhs: CommandWith<T>) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}

extension CommandWith: Codable {
    
    public convenience init(from decoder: Decoder) throws {
        self.init { _ in }
    }
    
    public func encode(to encoder: Encoder) throws {}
}

extension CommandWith {
    
    public func map<U>(transform: @escaping (U) -> T) -> CommandWith<U> {
        return CommandWith<U> { value in
            self.perform(with: transform(value))
        }
    }
}
