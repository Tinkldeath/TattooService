import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTextFied: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(recognizer)
    }
    
    @IBAction func continueClicked(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TattooStylesViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension UserDetailsViewController: InputViewController {
    
    @objc func dismissKeyboard() {
        self.nameTextFied.resignFirstResponder()
        self.ageTextField.resignFirstResponder()
    }
    
}
