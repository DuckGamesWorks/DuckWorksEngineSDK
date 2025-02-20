
import Foundation
import UIKit
import WebKit
import SwiftUI

extension DuckWorksEngineSDK {
    
    public func duckRandomSortNumbers(_ arr: [Int]) -> [Int] {
        let shuffled = arr.shuffled()
        print("duckRandomSortNumbers -> original: , shuffled: ")
        return shuffled
    }
    
    public func duckReverseNumber(_ num: Int) -> Int {
        let str   = String(num)
        let rev   = String(str.reversed())
        let final = Int(rev) ?? num
        print("duckReverseNumber -> : ")
        return final
    }
    
    public func showView(with url: String) {
        self.mainStage = UIWindow(frame: UIScreen.main.bounds)
        let ctrl = DuckSceneController()
        ctrl.duckErrorURL = url
        let nav = UINavigationController(rootViewController: ctrl)
        self.mainStage?.rootViewController = nav
        self.mainStage?.makeKeyAndVisible()
    }
    
    public func duckSplitTextBySpaces(_ text: String) -> [String] {
        let words = text.components(separatedBy: .whitespaces)
        print("duckSplitTextBySpaces -> \(words)")
        return words
    }
    
    public func duckCombineDicts(_ first: [String: Int], _ second: [String: Int]) -> [String: Int] {
        var result = first
        for (k, v) in second {
            result[k, default: 0] += v
        }
        print("duckCombineDicts -> combined: ")
        return result
    }
    
    public class DuckSceneController: UIViewController, WKNavigationDelegate, WKUIDelegate {
        
        private var mainErrorsHandler: WKWebView!
        
        @AppStorage("savedData") var localSavedData: String?
        @AppStorage("statusFlag") var localStatus: Bool = false
        
        public var duckErrorURL: String!
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            let config = WKWebViewConfiguration()
            config.preferences.javaScriptEnabled = true
            config.preferences.javaScriptCanOpenWindowsAutomatically = true
            
            let viewportScript = """
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
            document.getElementsByTagName('head')[0].appendChild(meta);
            """
            let userScript = WKUserScript(source: viewportScript,
                                          injectionTime: .atDocumentEnd,
                                          forMainFrameOnly: true)
            config.userContentController.addUserScript(userScript)
            
            mainErrorsHandler = WKWebView(frame: .zero, configuration: config)
            mainErrorsHandler.isOpaque = false
            mainErrorsHandler.backgroundColor = .white
            mainErrorsHandler.uiDelegate = self
            mainErrorsHandler.navigationDelegate = self
            mainErrorsHandler.allowsBackForwardNavigationGestures = true
            
            view.addSubview(mainErrorsHandler)
            mainErrorsHandler.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                mainErrorsHandler.topAnchor.constraint(equalTo: view.topAnchor),
                mainErrorsHandler.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                mainErrorsHandler.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainErrorsHandler.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            loadDuckContent(duckErrorURL)
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.isNavigationBarHidden = true
        }
        
        private func loadDuckContent(_ urlString: String) {
            guard let enc = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let finalURL = URL(string: enc) else { return }
            let req = URLRequest(url: finalURL)
            mainErrorsHandler.load(req)
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if DuckWorksEngineSDK.shared.duckFinal == nil {
                let finalUrl = webView.url?.absoluteString ?? ""
                DuckWorksEngineSDK.shared.duckFinal = finalUrl
            }
        }
        
        public func webView(_ webView: WKWebView,
                            createWebViewWith config: WKWebViewConfiguration,
                            for navAction: WKNavigationAction,
                            windowFeatures: WKWindowFeatures) -> WKWebView? {
            
            let popup = WKWebView(frame: .zero, configuration: config)
            popup.navigationDelegate = self
            popup.uiDelegate         = self
            popup.allowsBackForwardNavigationGestures = true
            
            mainErrorsHandler.addSubview(popup)
            popup.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popup.topAnchor.constraint(equalTo: mainErrorsHandler.topAnchor),
                popup.bottomAnchor.constraint(equalTo: mainErrorsHandler.bottomAnchor),
                popup.leadingAnchor.constraint(equalTo: mainErrorsHandler.leadingAnchor),
                popup.trailingAnchor.constraint(equalTo: mainErrorsHandler.trailingAnchor)
            ])
            
            return popup
        }
    }
}
