import UIKit
import Alamofire
import CryptoKit

class ViewController: UIViewController {
    
    var sectionsData: [MarvelCharacter] = []
    
    private var mainView: MainView {
        return view as! MainView
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        mainView.setupLayout()
        setupTableDataSourceDelegate()
        fetchMarvelCharacters()
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Marvel"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        view.addSubview(mainView.tableView)
    }
    
    private func setupTableDataSourceDelegate() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(MarvelCharacterTableViewCell.self, forCellReuseIdentifier: "MarvelCharacterCell")
    }
    
    private func fetchMarvelCharacters() {
        let apiKey = "bdd48a56f3f454e6bdfcd5fde74865d8"
        let privateKey = "92af51b58d8579e8ae6f6c242b23704d43ad2fc6"
        let baseURL = "https://gateway.marvel.com/v1/public/characters"
        
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(string: timestamp + privateKey + apiKey).map { String(format: "%02hhx", $0) }.joined()
        
        let parameters: [String: Any] = [
            "apikey": apiKey,
            "ts": timestamp,
            "hash": hash
        ]
        
        AF.request(baseURL, parameters: parameters).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let data = json["data"] as? [String: Any],
                   let results = data["results"] as? [[String: Any]] {
                    
                    for result in results {
                        if let name = result["name"] as? String,
                           let description = result["description"] as? String,
                           let thumbnail = result["thumbnail"] as? [String: Any],
                           let thumbnailURLString = thumbnail["path"] as? String,
                           let thumbnailExtension = thumbnail["extension"] as? String {
                            
                            let thumbnailURLString = thumbnailURLString + "." + thumbnailExtension
                            let thumbnailURL = URL(string: thumbnailURLString)
                            print("Thumbnail URL: \(thumbnailURLString)")
                            
                            let character = MarvelCharacter(name: name, description: description, thumbnailURL: thumbnailURL)
                            self.sectionsData.append(character)
                        }
                    }
                    
                    self.mainView.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error)")
            }
        }
    }
    
    private func MD5(string: String) -> Data {
        let data = Data(string.utf8)
        let hash = Insecure.MD5.hash(data: data)
        return Data(hash)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelCharacterCell", for: indexPath) as? MarvelCharacterTableViewCell
        let model = sectionsData[indexPath.row]
        cell?.configure(with: model)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailVC = CharacterDetailViewController()
        characterDetailVC.character = sectionsData[indexPath.row]
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}
