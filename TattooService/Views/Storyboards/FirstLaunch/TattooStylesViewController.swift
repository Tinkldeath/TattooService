import UIKit
import RxSwift
import RxCocoa


class TattooStyleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(_ title: String, _ image: UIImage?, _ selected: Bool) {
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.cornerRadius = 50
        self.titleLabel.text = title
        self.imageView.image = image
        self.titleLabel.textColor = selected ? UIColor.blue : UIColor.black
        self.imageView.layer.borderColor = (selected ? UIColor.blue : UIColor.black).cgColor
    }
    
}

class TattooStylesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: TattooStylesViewModelProtocol = TattooStylesViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupBindings()
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        self.navigate(to: "SignUpViewController")
    }
    
}

extension TattooStylesViewController {
    
    private func setupView() {
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = UIColor.label.cgColor
    }
    
    private func setupBindings() {
        self.viewModel.tattooStyles.bind(to: self.collectionView.rx.items(cellIdentifier: "StyleCell", cellType: TattooStyleCell.self)) { index, item, cell in
            cell.setup(item.title, UIImage(named: item.imageName), item.selected)
        }.disposed(by: self.disposeBag)
        self.collectionView.rx.itemSelected.bind { [weak self] indexPath in
            self?.viewModel.didSelectTattooStyle(indexPath.row)
        }.disposed(by: self.disposeBag)
    }
    
}
