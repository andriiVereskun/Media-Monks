//
//  Result.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

public func identity<Value>(_ value: Value) -> Value {
    return value
}

public func empty<Value>(_ value: Value) -> Value? {
    return nil
}

public func liftValue<Value, Error>(_ value: Value) -> Result<Value, Error> {
    return .success(value)
}

public func liftError<Value, Error>(_ error: Error) -> Result<Value, Error> {
    return .failure(error)
}


typealias PregsenseCommonResult<T, E> = Result<T, E>

public enum Result<TValue, TError> {

    case success(TValue)
    case failure(TError)
    
    // MARK: - Public properties
    
    public var value: TValue? {
        return self.analysis(ifValue: identity, ifError: { _ in nil })
    }
    
    public var error: TError? {
        return self.analysis(ifValue: { _ in nil }, ifError: identity)
    }
    
    public var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    public var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
    
    // MARK: - Lifecycle
    
    public init(value: TValue) {
        self = .success(value)
    }
    
    public init(error: TError) {
        self = .failure(error)
    }
    
    public init(value: TValue?, failWith error: @autoclosure () -> TError) {
        self = value.map(Result.success) ?? .failure(error())
    }
    
    public init(value: TValue?, error: @autoclosure () -> TError) {
        self = value.map(Result.success) ?? .failure(error())
    }
    
    // MARK: - Public methods
    
    public func analysis<Result>(ifValue: (TValue) -> Result, ifError: (TError) -> Result) -> Result {
        switch self {
        case let .success(value): return ifValue(value)
        case let .failure(error): return ifError(error)
        }
    }
    
    // MARK: Raw value related
    
    @discardableResult public func map<T, E>(ifSuccess: @escaping (TValue) -> T, ifFailure: @escaping (TError) -> E)
        -> Result<T, E>
    {
        return self.flatMap(ifSuccess: ifSuccess • liftValue, ifFailure: ifFailure • liftError)
    }
    
    @discardableResult public func mapValue<T>(_ transform: @escaping (TValue) -> T) -> Result<T, TError> {
        return self.map(ifSuccess: transform, ifFailure: identity)
    }
    
    @discardableResult public func mapError<E>(_ transform: @escaping (TError) -> E) -> Result<TValue, E> {
        return self.map(ifSuccess: identity, ifFailure: transform)
    }
    
    // MARK: Result value related
    
    public func flatMap<T, E>(ifSuccess: @escaping (TValue) -> Result<T, E>,
                              ifFailure: @escaping (TError) -> Result<T, E>) -> Result<T, E> {
        return self.analysis(ifValue: ifSuccess, ifError: ifFailure)
    }
    
    public func flatMapValue<T>(transform: @escaping (TValue) -> Result<T, TError>) -> Result<T, TError> {
        return self.flatMap(ifSuccess: transform, ifFailure: liftError)
    }
    
    public func flatMapError<E>(transform: @escaping (TError) -> Result<TValue, E>) -> Result<TValue, E> {
        return self.flatMap(ifSuccess: liftValue, ifFailure: transform)
    }
    
    // MARK: Syntactic sugar methods
    
    /***
     ifSuccess / ifFailure
     Instead of writing:
     
     switch result {
         case .success(let value): ...
         case .failure(let error): ...
     }
     
     You can use:
     
     result
         .ifSuccess { value in ... }
         .ifFailure { error in ... }
     */
    
    @discardableResult public func ifSuccess(_ block: (TValue) -> Void) -> Result<TValue, TError> {
        if case .success(let value) = self {
            block(value)
        }
        return self
    }
    
    @discardableResult public func ifFailure(_ block: (TError) -> Void) -> Result<TValue, TError> {
        if case .failure(let error) = self {
            block(error)
        }
        return self
    }
    
}

extension Result: Equatable {
    
    static public func == (lhs: Result<TValue, TError>, rhs: Result<TValue, TError>) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
            
        case (.failure, .failure):
            return true
            
        default:
            return false
        }
    }

}

extension Result where TValue: Equatable, TError: Equatable {
    
    static public func == (lhs: Result<TValue, TError>, rhs: Result<TValue, TError>) -> Bool {
        switch (lhs, rhs) {
        case (let .success(value1), let .success(value2)):
            return value1 == value2
            
        case (let .failure(error1), let .failure(error2)):
            return error1 == error2
            
        default:
            return false
        }
    }
    
}
