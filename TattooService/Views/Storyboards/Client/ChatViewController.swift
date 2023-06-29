import UIKit
import RxSwift
import RxCocoa


class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var backgroundMessageContentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(_ content: String) {
        self.contentLabel.text = content
        self.backgroundMessageContentView.layer.cornerRadius = 10
    }
    
}

class YourMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundMessageContentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var contentStack: UIStackView!
    
    func setup(_ content: String, _ media: [Data]?) {
        self.contentLabel.text = content
        self.backgroundMessageContentView.layer.cornerRadius = 10
        self.contentStack.arrangedSubviews.forEach({ ($0 as? UIImageView)?.removeFromSuperview() })
        media?.forEach { data in
            let imageView = UIImageView(image: UIImage(data: data))
            imageView.contentMode = .scaleAspectFit
            self.contentStack.addArrangedSubview(imageView)
        }
    }
    
}

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupKeyboardLayout()
    }
    
    private func setupView() {
        self.tableView.layer.borderWidth = 1
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
