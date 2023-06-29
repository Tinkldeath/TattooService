import UIKit


class GreetingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueClicked(_ sender: UIButton) {
        self.navigate(to: "UserDetailsViewController")
    }
    
    @IBAction func laterClicked(_ sender: Any) {
        self.navigate(storyboardName: "Client", viewControllerIdentifier: "MainViewController")
    }
    
}
