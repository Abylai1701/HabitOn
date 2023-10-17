import UIKit

final class HabbitsViewController: BaseController {
    
    //MARK: - Properties
    private let viewModel: HabbitsViewModelLogic = HabbitsViewModel()
    private var habbits: [HabbitModel] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(HabbitCell.self,
                       forCellReuseIdentifier: HabbitCell.cellId)
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    private lazy var createHabbit: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueColor
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .montserratSemiBold(ofSize: 14)
        button.setTitle("Create habbit".localized,
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
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchHabbits()
    }
    
    private func bind(){
        viewModel.habbits.observe(on: self) { habbits in
            self.habbits = habbits
            print(habbits,"Log")
            self.tableView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true,
                                                     animated: true)
    }
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(tableView, createHabbit)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-45-16)
        }
        createHabbit.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(203)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
    
    //MARK: - Functions
    @objc
    private func tapCreate() {
        let vc = CreateHabbitViewController()
        vc.modalPresentationStyle = .overCurrentContext
        Router.shared.show(vc)
    }
}


//MARK: - TableView Delegate
extension HabbitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        habbits.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HabbitCell.cellId,
            for: indexPath) as! HabbitCell
        cell.configure(model: habbits[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabbitDetailVC()
        vc.modalPresentationStyle = .overCurrentContext
        Router.shared.show(vc)
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let leftAction = UIContextualAction(style: .normal, title: "Перезагрузить") { (action, view, completionHandler) in
            completionHandler(true)
        }
        leftAction.backgroundColor = .yellowColor
        
        let leadingSwipeConfiguration = UISwipeActionsConfiguration(actions: [leftAction])
        
        return leadingSwipeConfiguration
    }
}
