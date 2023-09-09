
import UIKit

class MarvelCharacterTableViewCell: UITableViewCell {
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
            characterImageView.widthAnchor.constraint(equalToConstant: 80),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)  
        ])
    }
    
    func configure(with character: MarvelCharacter) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
        
        if let thumbnailURL = character.thumbnailURL {
            // Загрузите изображение из URL и установите его в characterImageView
            // Пример:
            // characterImageView.sd_setImage(with: thumbnailURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
