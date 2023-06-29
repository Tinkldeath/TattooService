import UIKit
import RxSwift
import RxCocoa


class ClientMainViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var navigationButtons: [UIButton]!
    @IBOutlet var navigationLabels: [UILabel]!
    @IBOutlet var navigationViews: [UIView]!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func navigationButtonClicked(_ sender: UIButton) {
        
    }
    
}
