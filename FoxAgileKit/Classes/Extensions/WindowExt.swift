//
//  WindowExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

public extension UIWindow {
    static func fak_keyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let window = scene.windows.first(where: { $0.isKeyWindow }) {
                return window
            }
        }
        return UIApplication.shared.delegate?.window ?? nil
    }

    static func fak_toppestVC(from controller: UIViewController) -> UIViewController {
        if let nav = controller as? UINavigationController,
           let toppestVC = nav.viewControllers.last {
            return fak_toppestVC(from: toppestVC)
        }
        if let tab = controller as? UITabBarController,
           let selectedVC = tab.selectedViewController {
            return fak_toppestVC(from: selectedVC)
        }
        if let presentedVC = controller.presentedViewController {
            return fak_toppestVC(from: presentedVC)
        }
        return controller
    }
    
    static func fak_toppestVC()-> UIViewController?{
        guard let keyWindow = fak_keyWindow(),
              let root = keyWindow.rootViewController else{
            return nil
        }
        return fak_toppestVC(from: root)
    }
}
