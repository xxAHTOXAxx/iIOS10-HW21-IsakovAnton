import UIKit

class MarvelCharacterTableViewCell: UITableViewCell {
   // @IBOutlet weak var characterImageView: UIImageView!
   // @IBOutlet weak var nameLabel: UILabel!
   // @IBOutlet weak var descriptionLabel: UILabel!
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupHierarchy() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 24),
            characterImageView.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: -10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(with character: MarvelCharacter) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
    // Дополнительные настройки и конфигурации кастомной ячейки
}
