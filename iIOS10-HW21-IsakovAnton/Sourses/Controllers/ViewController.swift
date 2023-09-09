import UIKit
import Alamofire


class ViewController: UIViewController {
    
    var sectionsData: [MarvelCharacter] = []
    
    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }
    
    // MARK: - LifeStyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = MainView()
        setupView()
        setupHierarchy()
        mainView?.setupLayout()
        setting()
        fetchMarvelCharacters()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Marvel"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        view.addSubview(mainView?.tableView ?? UITableView())
    }
    
    private func setting() {
        //sectionsData = MarvelCharacter.
        mainView?.tableView.dataSource = self
        mainView?.tableView.delegate = self
    }
    
    func fetchMarvelCharacters() {
        // код для выполнения запроса к API Marvel и получения данных о персонажах.
        //  Alamofire для выполнения GET-запроса:
        
        let apiKey = "bdd48a56f3f454e6bdfcd5fde74865d8"
        let baseURL = "https://gateway.marvel.com/v1/public/characters"
        
        let parameters: [String: Any] = [
            "apikey": apiKey
        ]
        
        AF.request(baseURL, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                // Обработайте данные JSON и обновите массив characters.
                // Пример: парсинг данных и обновление массива characters.
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
                            
                            let character = MarvelCharacter(name: name, description: description, thumbnailURL: thumbnailURL)
                            self.sectionsData.append(character)
                        }
                    }
                    
                    // Обновите таблицу после получения данных.
                    self.mainView?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error)")
            }
        }
        
    }
}
// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let model = sectionsData[indexPath.section][indexPath.row]
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelCharacterCell", for: indexPath) as? MarvelCharacterTableViewCell
            //cell?.configuration(model: model)
            return cell ?? UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = sectionsData[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


