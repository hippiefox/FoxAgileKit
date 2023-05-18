//
//  FAKProtoNavController.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

open class FAKProtoNavController: UINavigationController{
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
