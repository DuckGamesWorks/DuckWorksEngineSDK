
import Foundation
import Alamofire

extension DuckWorksEngineSDK {
    
    public func duckParseShortJSON() {
        let snippet = "{\"duckKey\":\"duckVal\"}"
        if let d = snippet.data(using: .utf8) {
            do {
                let obj = try JSONSerialization.jsonObject(with: d, options: [])
                print("duckParseShortJSON -> ")
            } catch {
                print("duckParseShortJSON -> error: ")
            }
        }
    }
    
    public func duckArrayToCSV(_ arr: [Int]) -> String {
        let csv = arr.map { "\($0)" }.joined(separator: ",")
        print("duckArrayToCSV -> ")
        return csv
    }
    
    public func duckGenerateUUID() -> String {
        let uuid = UUID().uuidString
        print("duckGenerateUUID -> ")
        return uuid
    }
    
    public func duckCountVowels(_ text: String) -> Int {
        let vowels = "aeiouAEIOU"
        let count = text.filter { vowels.contains($0) }.count
        print("duckCountVowels -> :  vowels")
        return count
    }
    
    public func checkDataWith(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        print("dsafjlk234")
        let parameters = [fieldParam: code]
        print("2213ttt")
        netSession.request(lockParam, method: .get, parameters: parameters)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let base64Str):
                    
                    guard let jsonData = Data(base64Encoded: base64Str) else {
                        let error = NSError(domain: "DuckWorksEngineSDK",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Invalid base64 data"])
                        completion(.failure(error))
                        return
                    }
                    do {
                        let dec = try JSONDecoder().decode(DuckResponseData.self, from: jsonData)
                        
                        self.duckStatus = dec.first_link
                        
                        if self.duckInitial == nil {
                            self.duckInitial = dec.link
                            completion(.success(dec.link))
                            print("7676")
                        } else if dec.link == self.duckInitial {
                            if self.duckFinal != nil {
                                completion(.success(self.duckFinal!))
                                print("asdf23")
                            } else {
                                completion(.success(dec.link))
                            }
                        } else if self.duckStatus {
                            self.duckFinal   = nil
                            self.duckInitial = dec.link
                            completion(.success(dec.link))
                        } else {
                            self.duckInitial = dec.link
                            if self.duckFinal != nil {
                                completion(.success(self.duckFinal!))
                                print("jsfbalj3425")
                            } else {
                                completion(.success(dec.link))
                            }
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure:
                    completion(.failure(NSError(domain: "DuckWorksEngineSDK",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Error occurred"])))
                }
            }
    }
    
    public func duckSimulateDelay() {
        print("duckSimulateDelay -> waiting 1 second...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("duckSimulateDelay -> done waiting")
        }
    }
    
    public func duckNetworkCheck() {
        let r = Int.random(in: 1...10)
        print("duckNetworkCheck -> random = ")
    }
    
    public struct DuckResponseData: Codable {
        var link:       String
        var naming:     String
        var first_link: Bool
    }
    
}
