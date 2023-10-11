import UIKit
enum ProfileMenuType {
    case notifications
    case support
    case share
    case confidence
    
    var title:String {
        switch self {
        case .notifications: return "Уведомления"
        case .support: return "Связаться с поддержкой"
        case .share: return "Поделиться приложением"
        case .confidence: return "Политика конфиденциальности"
        }
    }
}
final class SettingsViewController: BaseController {
    
    //MARK: - Properties
    var sections: [[ProfileMenuType]] = [[.notifications],
                                         [.support,
                                          .share,
                                          .confidence]]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MenuCell.self,
                       forCellReuseIdentifier: MenuCell.cellId)
        table.register(MenuNotificationCell.self,
                       forCellReuseIdentifier: MenuNotificationCell.cellId)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true,
                                                     animated: true)
    }
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-45-16)
        }
    }
}


//MARK: - TableView Delegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section][indexPath.row]
        
        switch model{
        case .notifications:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuNotificationCell.cellId,
                                                     for: indexPath) as! MenuNotificationCell
            cell.configure(model: model)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellId,
                                                     for: indexPath) as! MenuCell
            cell.configure(model: model)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
