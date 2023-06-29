import Foundation
import RxSwift


protocol UserDetailsViewModelProtocol {
    
    var isContinueEnabled: BehaviorSubject<Bool> { get }
    var namePlaceholder: BehaviorSubject<String> { get }
    var intValuePlaceholder: BehaviorSubject<String> { get }
    
    func didChangeRole(_ role: Int)
    func didEnterInput(_ role: Int, _ name: String, _ intValue: Int)
    
}


class UserDetailsViewModel: UserDetailsViewModelProtocol {
    
    private(set) var isContinueEnabled: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    private(set) var namePlaceholder: BehaviorSubject<String> = BehaviorSubject(value: "Your name")
    private(set) var intValuePlaceholder: BehaviorSubject<String> = BehaviorSubject(value: "Your work experience (years)")
    
    private let validator = Validator()
    
    func didChangeRole(_ role: Int) {
        switch role {
        case 0:
            self.intValuePlaceholder.onNext("Your work experience (years)")
        default:
            self.intValuePlaceholder.onNext("Your age")
        }
    }
    
    func didEnterInput(_ role: Int, _ name: String, _ intValue: Int) {
        switch role {
        case 0:
            self.isContinueEnabled.onNext(self.validator.validateTattooArtist(name, intValue))
        default:
            self.isContinueEnabled.onNext(self.validator.validateClient(name, intValue))
        }
    }
    
}

extension UserDetailsViewModel {
    
    struct Validator {
        func validateTattooArtist(_ name: String, _ experience: Int) -> Bool {
            return name.count > 0 && experience >= 0
        }
        func validateClient(_ name: String, _ age: Int) -> Bool {
            return name.count > 0 && age >= 18
        }
    }
    
}
