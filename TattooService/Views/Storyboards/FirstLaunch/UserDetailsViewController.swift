import UIKit
import RxSwift
import RxCocoa


class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTextFied: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var continueButton: UIButton!
    
    private let viewModel: UserDetailsViewModelProtocol = UserDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupKeyboardLayout()
        self.setupView()
    }
    
    @IBAction func continueClicked(_ sender: UIButton) {
        self.navigate(to: "TattooStylesViewController")
    }
    
    private func setupView() {
        self.viewModel.isContinueEnabled.bind(to: self.continueButton.rx.isEnabled).disposed(by: self.disposeBag)
        self.viewModel.namePlaceholder.bind(to: self.nameTextFied.rx.placeholder).disposed(by: self.disposeBag)
        self.viewModel.intValuePlaceholder.bind(to: self.ageTextField.rx.placeholder).disposed(by: self.disposeBag)
        self.segmentedControl.rx.selectedSegmentIndex.bind { [weak self] value in
            self?.viewModel.didChangeRole(value)
            self?.validateInput()
        }.disposed(by: self.disposeBag)
        self.nameTextFied.rx.value.bind { [weak self] _ in
            self?.validateInput()
        }.disposed(by: self.disposeBag)
        self.ageTextField.rx.value.bind { [weak self] _ in
            self?.validateInput()
        }.disposed(by: self.disposeBag)
    }
    
    private func validateInput() {
        self.viewModel.didEnterInput(self.segmentedControl.selectedSegmentIndex, self.nameTextFied.text.orEmpty(), self.ageTextField.text.asInt())
    }
    
}
