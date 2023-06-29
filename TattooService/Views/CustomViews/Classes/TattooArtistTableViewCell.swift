import UIKit


class TattooArtistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var stylesLabel: UILabel!
    @IBOutlet weak var worksLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followButtonTitle: UILabel!
    @IBOutlet weak var premium: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ name: String, _ experience: String, _ styles: String, _ image: Data?, _ works: String, _ premium: Bool, _ following: Bool) {
        self.nameLabel.text = name
        self.experienceLabel.text = experience
        self.stylesLabel.text = styles
        self.worksLabel.text = works
        self.setFollowing(following)
        self.setPremium(premium)
        self.setProfileImage(image)
    }
    
    private func setProfileImage(_ data: Data?) {
        guard let data = data else { return }
        self.profileImageView.image = UIImage(data: data)
    }
    
    private func setFollowing(_ isFollowing: Bool) {
        if isFollowing {
            self.followButton.setImage(UIImage(systemName: "person"), for: .normal)
            self.followButtonTitle.text = "Following"
        } else {
            self.followButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
            self.followButtonTitle.text = "Follow"
        }
    }
    
    private func setPremium(_ isPremium: Bool) {
        self.premium.isHidden = !isPremium
    }
    
}
