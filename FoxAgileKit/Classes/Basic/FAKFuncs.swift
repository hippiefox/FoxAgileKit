//
//  FAKFuncs.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
public func FAKLog(_ items: Any...,
                  separator: String = " ",
                  terminator: String = "\n",
                  file: String = #file,
                  line: Int = #line,
                  method: String = #function)
{
    guard FoxAgileKitConfig.isLogEnabled else { return }
    
    print("\n\((file as NSString).lastPathComponent) [\(line)] \(method)")
    print(items, separator: separator, terminator: terminator)
}

public func FAKLocalized(_ key: String)-> String{
    NSLocalizedString(key, comment: "")
}
