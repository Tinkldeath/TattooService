import UIKit
import RxCocoa
import RxSwift


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let viewModel: SignUpViewModelProtocol = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupKeyboardLayout()
        self.setupView()
        self.setupBindings()
    }
    
    @IBAction func setPictureClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let possibleImage = info[.originalImage] as? UIImage else { return }
        self.imageView.image = possibleImage
        self.imageView.contentMode = .scaleAspectFill
        picker.dismiss(animated: true)
    }
    
}

extension SignUpViewController {
    
    private func setupView() {
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.label.cgColor
        self.errorLabel.text = ""
    }
    
    private func setupBindings() {
        self.viewModel.validatorMessage.bind(to: self.errorLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.isContinueEnabled.bind(to: self.continueButton.rx.isEnabled).disposed(by: self.disposeBag)
        self.loginTextField.rx.controlEvent(.editingDidEnd).bind { [weak self] _ in
            self?.validateInput()
        }.disposed(by: self.disposeBag)
        self.passwordTextField.rx.controlEvent(.editingDidEnd).bind { [weak self] _ in
            self?.validateInput()
        }.disposed(by: self.disposeBag)
        self.continueButton.rx.controlEvent(.touchUpInside).bind { [weak self] _ in
            self?.presentLoading()
            self?.viewModel.didClickContinue()
        }.disposed(by: self.disposeBag)
        self.viewModel.signUpTrigger.bind { [weak self] (completed: Bool, message: String) in
            if completed {
                self?.presentMessageWithCompletion("Success", "Successfully signed up!", {
                    self?.navigate(storyboardName: message, viewControllerIdentifier: "MainViewController")
                })
            } else {
                self?.presentMessage("Error", message)
            }
            self?.presentEndLoading()
        }.disposed(by: self.disposeBag)
    }
    
    private func validateInput() {
        self.viewModel.didFillLoginAndPassword(self.loginTextField.text.orEmpty(), self.passwordTextField.text.orEmpty(), self.imageView.image?.jpeg(.lowest))
    }
    
}
