import Foundation


extension String? {
    
    func orEmpty() -> String {
        guard let value = self else { return "" }
        return value
    }
    
    func asInt() -> Int {
        guard let value = self else { return 0 }
        guard let intValue = Int(value) else { return 0 }
        return intValue
    }
    
}
