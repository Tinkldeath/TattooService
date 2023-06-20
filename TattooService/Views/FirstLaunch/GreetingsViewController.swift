import UIKit

class GreetingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueClicked(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
