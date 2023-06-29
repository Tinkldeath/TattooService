import UIKit

class WorkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var saveButtonTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.outlineView.layer.cornerRadius = 10
        self.outlineView.layer.borderWidth = 1
        self.outlineView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ name: String, _ style: String, _ tags: String, _ profileImage: Data?, _ workImage: Data?, _ saved: Bool) {
        self.nameLabel.text = name
        self.styleLabel.text = style
        self.tagsLabel.text = tags
        self.setProfileImage(profileImage)
        self.setWorkImage(workImage)
        self.setSaved(saved)
    }
    
    private func setProfileImage(_ data: Data?) {
        guard let data = data else { return }
        self.profileImage.image = UIImage(data: data)
    }
    
    private func setWorkImage(_ data: Data?) {
        guard let data = data else { return }
        self.workImageView.image = UIImage(data: data)
    }
    
    private func setSaved(_ isSaved: Bool) {
        if isSaved {
            self.saveButton.setImage(UIImage(systemName: "tray.full.fill"), for: .normal)
            self.saveButtonTitle.text = "Saved"
        } else {
            self.saveButton.setImage(UIImage(systemName: "tray"), for: .normal)
            self.saveButtonTitle.text = "Save"
        }
    }

}
