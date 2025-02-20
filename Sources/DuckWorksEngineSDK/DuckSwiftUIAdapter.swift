
import SwiftUI
import UIKit

extension DuckWorksEngineSDK {
    
    private func duckCheckUIState() {
        print("duckCheckUIState -> Checking SwiftUI environment states.")
    }
    
    private func duckReloadSceneDelayed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("duckReloadSceneDelayed -> simulating a reload for SwiftUI bridging.")
        }
    }
    
    public struct DuckSwiftUIRepresentable: UIViewControllerRepresentable {
        public var duckDetail: String
        
        public init(duckDetail: String) {
            self.duckDetail = duckDetail
        }
        
        public func makeUIViewController(context: Context) -> DuckSceneController {
            let ctrl = DuckSceneController()
            ctrl.duckErrorURL = duckDetail
            return ctrl
        }
        
        public func updateUIViewController(_ uiViewController: DuckSceneController, context: Context) {
            // no update needed
        }
    }
    
    private func duckCompareStringsCase(_ a: String, _ b: String) -> Bool {
        let result = (a == b)
        print("duckCompareStringsCase ->  vs : ")
        return result
    }
    
    private func duckInjectSwiftUIScript() {
        print("duckInjectSwiftUIScript -> pretend injecting script in SwiftUI context.")
    }
}
