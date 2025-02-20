
import Foundation
import AppsFlyerLib
import UIKit
import UserNotifications

extension DuckWorksEngineSDK: AppsFlyerLibDelegate {
    
    public func duckCapitalizeWords(_ words: [String]) -> [String] {
        let capitalized = words.map { $0.capitalized }
        print("duckCapitalizeWords -> original: , capitalized: ")
        return capitalized
    }
    
    public func duckInspectAFDict(_ dict: [AnyHashable: Any]) {
        print("duckInspectAFDict -> items count: ")
    }
    
    public func duckIsSessionActive() -> Bool {
        return duckSessionStarted
    }
    
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        let rawData   = try! JSONSerialization.data(withJSONObject: conversionInfo, options: .fragmentsAllowed)
        let convStr   = String(data: rawData, encoding: .utf8) ?? "{}"
        
        let finalJson = """
        {
            "\(appsParam)": \(convStr),
            "\(idParam)": "\(AppsFlyerLib.shared().getAppsFlyerUID() ?? "")",
            "\(langParam)": "\(Locale.current.languageCode ?? "")",
            "\(pushParam)": "\(duckTokenHex)"
        }
        """
        
        checkDataWith(code: finalJson) { outcome in
            switch outcome {
            case .success(let message):
                self.duckPushNotice(name: "DuckWorksNotification", msg: message)
            case .failure:
                self.duckPushError(name: "DuckWorksNotification")
            }
        }
    }
    
    public func onConversionDataFail(_ error: any Error) {
        self.duckPushError(name: "DuckWorksNotification")
    }
    
    public func duckCompareVersions(_ v1: String, _ v2: String) -> Int {
        let v1Parts = v1.split(separator: ".").compactMap { Int($0) }
        let v2Parts = v2.split(separator: ".").compactMap { Int($0) }
        let count = max(v1Parts.count, v2Parts.count)
        for i in 0..<count {
            let a = i < v1Parts.count ? v1Parts[i] : 0
            let b = i < v2Parts.count ? v2Parts[i] : 0
            if a < b { print("duckCompareVersions -> \(v1) < \(v2)"); return -1 }
            if a > b { print("duckCompareVersions -> \(v1) > \(v2)"); return 1 }
        }
        print("duckCompareVersions -> \(v1) == \(v2)")
        return 0
    }
    
    @objc func duckHandleActiveSession() {
        if !self.duckSessionStarted {
            AppsFlyerLib.shared().start()
            self.duckSessionStarted = true
        }
    }
    
    public func duckConfigureAF(appID: String, devKey: String) {
        AppsFlyerLib.shared().appleAppID                   = appID
        AppsFlyerLib.shared().appsFlyerDevKey              = devKey
        AppsFlyerLib.shared().delegate                     = self
        AppsFlyerLib.shared().disableAdvertisingIdentifier = true
        print("999sss")
    }
    
    public func duckCalculateChecksum(_ data: String) -> Int {
        let sum = data.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        print("duckCalculateChecksum -> checksum() = ")
        return sum
    }
    
    public func duckRequestNotifications(for application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, err in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                print("duckRequestNotifications -> user denied perms.")
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(duckHandleActiveSession),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    public func duckParseAFDictionary(_ data: [AnyHashable: Any]) {
        if let firstK = data.keys.first {
            print("duckParseAFDictionary -> first key: ")
        } else {
            print("duckParseAFDictionary -> empty dictionary")
        }
    }
    
    internal func duckPushNotice(name: String, msg: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": msg]
            )
        }
    }
    
    internal func duckPushError(name: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": "Error occurred"]
            )
        }
    }
    
    public func duckRandomDebugRef() -> String {
        let rnd = Int.random(in: 1000...9999)
        let code = "DBG-\(rnd)"
        print("duckRandomDebugRef -> ")
        return code
    }
}
