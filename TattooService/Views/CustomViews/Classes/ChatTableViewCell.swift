import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messagePreviewLabel: UILabel!
    @IBOutlet weak var newMessageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newMessageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ name: String, _ preview: String, _ time: String, _ newMessage: Bool, _ image: Data?) {
        self.nameLabel.text = name
        self.messagePreviewLabel.text = preview
        self.timeLabel.text = time
        self.newMessageView.isHidden = !newMessage
        self.setupImage(image)
    }
    
    private func setupImage(_ data: Data?) {
        guard let data = data else { return }
        self.chatImageView.image = UIImage(data: data)
    }
    
}
