//
//  FAKEnumClosure.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation

public typealias FAKValueBlock<Value> = (Value)->Void
public typealias FAKNullBlock<Value> = ()->Void

public enum FAKResult<Value0,Value1>{
    case success(Value0)
    case failure(Value1)
}

public enum FAKNullResult{
    case success
    case failure
}

public enum FAKValueResult<Value>{
    case success(Value)
    case failure(Value)
}

public enum FAKSuccessResult<Value>{
    case success(Value)
    case failure
}

public enum FAKErrorResult<Value>{
    case success
    case failure(Value)
}

