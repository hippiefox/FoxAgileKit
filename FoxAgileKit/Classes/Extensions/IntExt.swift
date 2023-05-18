//
//  IntExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation

public extension Int{
    /// HH:mm:ss
    func fak_durationTimeFormat()-> String{
        let duration = self
        let h = duration / 3600
        let hours = String(format: "%02d", h)
        let m = duration % 3600 / 60
        let minites = String(format: "%02d", m)
        let s = duration % 60
        let seconds = String(format: "%02d", s)
        if h > 0 { return "\(hours):\(minites):\(seconds)" }
        if m > 0 { return "\(minites):\(seconds)" }
        return "0:\(seconds)"
    }
    
    func fak_storageSizeFormat(unit: ByteCountFormatter.Units = .useAll, includesUnit: Bool = true)-> String{
        let format = ByteCountFormatter()
        format.allowedUnits = unit
        format.countStyle = .binary
        format.includesUnit = includesUnit
        return format.string(fromByteCount: .init(self))
    }
}
