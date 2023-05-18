//
//  ColorExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

public extension UIColor {
    static func fak_hex(_ colorStr: String) -> UIColor {
        var rawHexStr = colorStr
        rawHexStr = (rawHexStr as NSString).replacingOccurrences(of: "#", with: "")
        rawHexStr = (rawHexStr as NSString).replacingOccurrences(of: "0x", with: "")
        rawHexStr = (rawHexStr as NSString).replacingOccurrences(of: "0X", with: "")
        var hexValue: UInt64 = 0
        let scanner = Scanner(string: .init(rawHexStr))
        let isValidHex = scanner.scanHexInt64(&hexValue)

        guard isValidHex else { return .clear }

        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1
        if rawHexStr.count == 6 {
            r = CGFloat((hexValue & 0xFF0000) >> 16) / 255
            g = CGFloat((hexValue & 0x00FF00) >> 8) / 255
            b = CGFloat((hexValue & 0x0000FF) >> 0) / 255
        }
        if rawHexStr.count == 8 {
            r = CGFloat((hexValue & 0xFF000000) >> 24) / 255
            g = CGFloat((hexValue & 0x00FF0000) >> 16) / 255
            b = CGFloat((hexValue & 0x0000FF00) >> 8) / 255
            a = CGFloat((hexValue & 0x000000FF) >> 0) / 255
        }
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
