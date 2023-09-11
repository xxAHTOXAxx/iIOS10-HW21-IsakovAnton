import UIKit

class CharacterDetailViewController: UIViewController {
    var character: MarvelCharacter?

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        populateData()
    }

    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Character Detail"
    }

    private func setupLayout() {
        view.addSubview(characterImageView)
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),

            descriptionLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

    private func populateData() {
        if let character = character {
            characterImageView.kf.setImage(with: character.thumbnailURL)
            descriptionLabel.text = character.description
        }
    }
}
