import Foundation
import RxSwift


protocol SignUpViewModelProtocol {
    
    var isContinueEnabled: BehaviorSubject<Bool> { get }
    var validatorMessage: BehaviorSubject<String> { get }
    var signUpTrigger: PublishSubject<(completed: Bool, message: String)> { get }
    
    func didFillLoginAndPassword(_ login: String, _ password: String, _ image: Data?)
    func didClickContinue()
    
}

class SignUpViewModel: SignUpViewModelProtocol {
    
    private(set) var isContinueEnabled: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    private(set) var validatorMessage: BehaviorSubject<String> = BehaviorSubject(value: "")
    private(set) var signUpTrigger: PublishSubject<(completed: Bool, message: String)> = PublishSubject()
    
    private var loginValidator = LoginValidator()
    private let passwordValidator = PasswordValidator()
    
    func didFillLoginAndPassword(_ login: String, _ password: String, _ image: Data?) {
        let loginValidationResult = self.loginValidator.validate(login)
        let passwordValidationResult = self.passwordValidator.validate(password)
        self.isContinueEnabled.onNext(loginValidationResult.isValid && passwordValidationResult.isValid)
        self.validatorMessage.onNext(loginValidationResult.message.orEmpty() + passwordValidationResult.message.orEmpty())
    }
    
    func didClickContinue() {
        self.signUpTrigger.onNext((true, "Client"))
    }
    
}

extension SignUpViewModel {
    
    struct PasswordValidator {
        func validate(_ password: String) -> (isValid: Bool, message: String?) {
            guard password.count >= 8 else {
                return (false, "Password length must be at least 8 characters")
            }
            guard password.contains(where: { $0.isNumber }) else {
                return (false, "Password must have at least one number")
            }
            guard password.contains(where: { $0.isUppercase }) else {
                return (false, "Password must have at least one uppercase character")
            }
            return (true, nil)
        }
    }

    struct LoginValidator {
        private(set) var logins: [String] = []
        mutating func setup(_ logins: [String]) {
            self.logins = logins
        }
        func validate(_ login: String) -> (isValid: Bool, message: String?) {
            guard login.count >= 4 else {
                return (false, "Login length must be at least 4 characters")
            }
            guard !self.logins.contains(login) else {
                return (false, "Login \(login) already exists. Please, try another")
            }
            return (true, nil)
        }
    }
    
}
