//
//  FAKDeviceRotate.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
/*
    iPhone Orientation:Portrait

 func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return FAKDeviceRotate.allowedOrientation
 }
 */

public struct FAKDeviceRotate {
    public static var allowedOrientation: UIInterfaceOrientationMask = .portrait

    public static func rotateHrizontal() {
        FAKDeviceRotate.allowedOrientation = .landscapeRight
        UIDevice.current.setValue(3, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    public static func rotateVertical() {
        FAKDeviceRotate.allowedOrientation = .portrait
        UIDevice.current.setValue(1, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    public static func toggleOrientation() {
        if FAKDeviceRotate.allowedOrientation == .portrait {
            rotateHrizontal()
        } else {
            rotateVertical()
        }
    }
}
