//
//  ButtonExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

public extension UIButton{
    @discardableResult
    func fak_simpleCountDown(duration: Int = 60,
                             countingClosure: ((Int)->Void)? = nil,
                             atStartTitle: String? = nil,
                             finishClosure:(()->Void)? = nil)-> DispatchSourceTimer{
        isEnabled = false
        let atStartTS = Date().timeIntervalSince1970
        let timer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0),queue: .global())
        timer.schedule(deadline: .now(),repeating: .milliseconds(1000))
        timer.setEventHandler {
            DispatchQueue.main.async {
                let nowTS = Date().timeIntervalSince1970
                let leftSeconds = duration - Int(nowTS-atStartTS)
                if leftSeconds < 0{
                    timer.cancel()
                    self.isEnabled = true
                    self.setTitle(atStartTitle, for: .normal)
                    finishClosure?()
                }else{
                    self.setTitle("\(leftSeconds)s", for: .normal)
                    countingClosure?(leftSeconds)
                }
            }
        }
        timer.activate()
        return timer
    }
}
