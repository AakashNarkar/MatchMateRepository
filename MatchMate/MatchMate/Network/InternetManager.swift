//
//  InternetManager.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import Foundation
import Alamofire

extension Notification.Name {
    static let networkDidChange = Notification.Name(rawValue: AppConstant.kReachabilityDidChangeNotification)
}

final class InternetManager: NSObject {
    static var shared = InternetManager()
    var reachabilityManager = NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                NotificationCenter.default.post(name: .networkDidChange, object: AppConstant.offline)
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                NotificationCenter.default.post(name: .networkDidChange, object: AppConstant.online)
            case .unknown:
                print("Internet connection status unknown.")
            }
        }
    }
    
    func stopNetworkReachabilityObserver() {
        reachabilityManager?.stopListening()
    }
}

