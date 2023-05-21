//
//  FAKNetListener.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/21.
//

import Foundation
import RealReachability

public extension FAKNetListener{
    enum NetStatus{
        case unknown
        case accessed
        case lost
    }
}

public class FAKNetListener{
    public static let shared = FAKNetListener()
    
    private(set) var lastNetStatus: ReachabilityStatus = .RealStatusUnknown
    private var changeBlock: ((NetStatus)->Void)?
    
    public func listen(changeBlock:@escaping (NetStatus)->Void){
        guard let rr = RealReachability.sharedInstance() else { return }
        self.changeBlock = changeBlock
        rr.startNotifier()
        lastNetStatus = rr.currentReachabilityStatus()
        NotificationCenter.default.addObserver(self, selector: #selector(notiNetworkChange(_:)), name: NSNotification.Name.realReachabilityChanged, object: nil)
    }
    
    @objc private func notiNetworkChange(_ noti: Notification){
        guard let reachability = noti.object as? RealReachability else { return }
        
        let newStatus = reachability.currentReachabilityStatus()
        if lastNetStatus == .RealStatusUnknown ||
            lastNetStatus == .RealStatusNotReachable
        {
            if newStatus == .RealStatusViaWWAN ||
                newStatus == .RealStatusViaWiFi
            {
                self.changeBlock?(.accessed)
            }
        }
        
        if case .RealStatusNotReachable = newStatus{
            self.changeBlock?(.lost)
        }
        lastNetStatus = newStatus
    }
}
