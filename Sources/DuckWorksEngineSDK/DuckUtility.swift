
import Foundation
import UIKit

extension DuckWorksEngineSDK {
    
    public func duckMergeIntArrays(_ a: [Int], _ b: [Int]) -> [Int] {
        var combined = a
        for x in b {
            if !combined.contains(x) {
                combined.append(x)
            }
        }
        print("duckMergeIntArrays -> ")
        return combined
    }
    
    public func duckIsPalindromeIgnoreCase(_ text: String) -> Bool {
        let lower = text.lowercased()
        let rev   = String(lower.reversed())
        let result = (lower == rev)
        print("duckIsPalindromeIgnoreCase -> : ")
        return result
    }
    
    public func duckRandomRefID() -> String {
        let code = Int.random(in: 1000...9999)
        let ref = "DW-\(code)"
        print("duckRandomRefID -> ")
        return ref
    }
    
    public func duckLocalDataCheck() {
        let rnd = Int.random(in: 0...20)
        print("duckLocalDataCheck -> random: ")
    }

    public func duckHasDuplicateString(_ arr: [String]) -> Bool {
        let setCount = Set(arr).count
        let result = (setCount != arr.count)
        print("duckHasDuplicateString -> ")
        return result
    }
}
