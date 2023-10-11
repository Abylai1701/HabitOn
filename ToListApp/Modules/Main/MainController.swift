import UIKit

final class MainController: BaseController {
    
    //MARK: - Properties
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MainCell.self,
                       forCellReuseIdentifier: MainCell.cellId)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    private lazy var yourLeftView: DoneView = {
        let view = DoneView()
        tableView.addSubview(view)
        view.frame = CGRect(x: -view.frame.width, y: 0, width: view.frame.width, height: tableView.bounds.size.height)
        return view
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueColor
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .montserratSemiBold(ofSize: 14)
        button.setTitle("create_goal".localized,
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        button.addTarget(self,
                         action: #selector(tapCreate),
                         for: .touchUpInside)
        button.setImage(UIImage(named:"File add"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 24
        )
        return button
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
        
        view.addSubviews(tableView, createButton)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(203)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
    
    //MARK: - Functions
    @objc
    private func tapCreate() {
        let vc = CreateGoalVC()
        vc.modalPresentationStyle = .overCurrentContext
        Router.shared.show(vc)
    }
}


//MARK: - TableView Delegate
extension MainController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainCell.cellId,
            for: indexPath) as! MainCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Создайте действие для свайпа влево
        let leftAction = UIContextualAction(style: .normal, title: "Готово") { (action, view, completionHandler) in
            // Здесь можно выполнять действия, связанные с левым свайпом
            completionHandler(true)
        }
        leftAction.backgroundColor = .greenColor // Установите цвет для действия
        
        // Создайте конфигурацию для левого свайпа
        let leadingSwipeConfiguration = UISwipeActionsConfiguration(actions: [leftAction])
        
        return leadingSwipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Создайте действие для свайпа вправо
        let rightAction = UIContextualAction(style: .normal, title: "Изменить") { (action, view, completionHandler) in
            // Здесь можно выполнять действия, связанные с правым свайпом
            completionHandler(true)
        }
        rightAction.backgroundColor = .yellowColor // Установите цвет для действия
        
        // Создайте конфигурацию для правого свайпа
        let trailingSwipeConfiguration = UISwipeActionsConfiguration(actions: [rightAction])
        
        return trailingSwipeConfiguration
    }
}


