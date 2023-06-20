import UIKit
import RxSwift
import RxCocoa


class TattooStyleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var selection = false {
        didSet {
            self.imageView.layer.borderColor = self.selection ? UIColor.blue.cgColor : UIColor.label.cgColor
            self.titleLabel.textColor = self.selection ? UIColor.blue : UIColor.label
        }
    }
    
    func setup(_ title: String) {
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.cornerRadius = 49
        self.imageView.layer.borderColor = UIColor.label.cgColor
        self.titleLabel.text = title
    }
    
    func selected() {
        self.selection = !self.selection
    }
    
}

class TattooStylesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var items = PublishSubject<[String]>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = UIColor.label.cgColor
        self.items.observe(on: MainScheduler.instance).bind(to: self.collectionView.rx.items(cellIdentifier: "StyleCell", cellType: TattooStyleCell.self)) { row, item , cell in
            cell.setup(item)
        }.disposed(by: self.disposeBag)
        self.collectionView.rx.itemSelected.observe(on: MainScheduler.instance).bind { [weak self] index in
            if let cell = self?.collectionView.cellForItem(at: index) as? TattooStyleCell {
                cell.selected()
            }
        }.disposed(by: self.disposeBag)
        self.items.onNext(["Traditional/Old School", "New School", "Neo Traditional", "Realism", "Watercolor", "Tribal", "Trash Polka", "Geometric"])
    }
    
}
