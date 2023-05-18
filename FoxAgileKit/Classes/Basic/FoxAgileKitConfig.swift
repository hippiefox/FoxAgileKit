//
//  FoxAgileKitConfig.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation

public struct FoxAgileKitConfig {
    public static var isLogEnabled = false

    public static var nav_bg_color = UIColor.white
    public static var nav_bg_alpha: CGFloat = 1
    public static var nav_back_image: UIImage?
    public static var nav_title_color: UIColor = .black
    public static var nav_title_font = UIFont.systemFont(ofSize: 18)
    /// 左右内容间距
    public static var nav_content_hrz_inset: CGFloat = 10
    /// 按钮间距
    public static var nav_item_space: CGFloat = 10
    /// 按钮颜色
    public static var nav_item_color: UIColor = .black
    public static var nav_item_font = UIFont.systemFont(ofSize: 17)
    /// 底部黑线颜色
    public static var nav_shadow_line_color = UIColor.lightGray
    public static var nav_height_notX_height: CGFloat = 64
}
