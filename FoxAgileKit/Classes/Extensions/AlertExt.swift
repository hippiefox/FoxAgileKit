//
//  AlertExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

public extension UIAlertController {
    static func fak_show(from controller: UIViewController,
                         title: String?,
                         message: String? = nil,
                         cancel: String?,
                         cancelClosure: (() -> Void)? = nil,
                         cancelColor: UIColor? = nil,
                         done: String?,
                         doneClosure: (() -> Void)?,
                         doneColor: UIColor? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let cancel = cancel {
            let action = UIAlertAction(title: cancel, style: .cancel) { _ in
                cancelClosure?()
            }
            if let color = cancelColor {
                action.setValue(color, forKey: "_titleTextColor")
            }
            alert.addAction(action)
        }

        if let done = done {
            let action = UIAlertAction(title: done, style: .default) { _ in
                doneClosure?()
            }
            if let color = doneColor {
                action.setValue(color, forKey: "_titleTextColor")
            }
            alert.addAction(action)
        }

        controller.present(alert, animated: true)
    }
}
