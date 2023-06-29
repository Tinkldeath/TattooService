import UIKit

class FilterView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        if let nib = Bundle.main.loadNibNamed("FilterView", owner: self)?.first as? UIView {
            nib.frame = self.bounds
            self.addSubview(nib)
            self.tableView.register(UINib(nibName: "WorkTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkCell")
            self.tableView.register(UINib(nibName: "TattooArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "TattooArtistCell")
            self.tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        }
    }
    
    func setFilterHidden(_ isHidden: Bool) {
        self.filterLabel.isHidden = isHidden
        self.filterButton.isHidden = isHidden
    }

}
