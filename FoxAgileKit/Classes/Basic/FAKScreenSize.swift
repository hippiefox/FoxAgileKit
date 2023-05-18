//
//  FAKScreenSize.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation

public struct FAKScreenSize {
    public static let width: CGFloat = UIScreen.main.bounds.width
    public static let height: CGFloat = UIScreen.main.bounds.height
    public static let safeAreaInset: UIEdgeInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    public static let navHeightNotX: CGFloat = 64
    public static var navHeight: CGFloat { safeAreaInset.top > 0 ? safeAreaInset.top + 44 : navHeightNotX }
}
