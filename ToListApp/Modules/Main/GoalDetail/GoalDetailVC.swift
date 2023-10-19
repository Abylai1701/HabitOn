import Foundation
import UIKit

enum GoalDetailMenuType {
    case first
    case second
    case third
}

final class GoalDetailVC: BaseController {
    
    //MARK: - Properties
    var sections: [GoalDetailMenuType] = [.first,
                                          .second,
                                          .third]
    
    private let viewModel: GoalDetailViewModelLogic = GoalDetailViewModel()
    private var goalModel: GoalDetailModel?
    
    var doneAction: (()->())?
    var deleteAction: (()->())?

    private var id: Int
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "exit_icon2"), for: .normal)
        button.layer.masksToBounds = false
        button.addTarget(self,
                         action: #selector(tapBack),
                         for: .touchUpInside)
        return button
    }()
    private lazy var editButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "edit_icon")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.isHidden = true
        return view
    }()
    private lazy var deleteButton: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "delete_icon")
        view.contentMode = .scaleAspectFit
        let target = UITapGestureRecognizer(target: self, action: #selector(tapDelete))
        view.addGestureRecognizer(target)
        return view
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(GoalProgressCell.self,
                       forCellReuseIdentifier: GoalProgressCell.cellId)
        table.register(GoalWeekCell.self,
                       forCellReuseIdentifier: GoalWeekCell.cellId)
        table.register(HistoryCell.self,
                       forCellReuseIdentifier: HistoryCell.cellId)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    // MARK: - Init
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGoalDetail(id: self.id)
    }
    func bind() {
        viewModel.goalDetail.observe(on: self) { goal in
            self.goalModel = goal
            self.tableView.reloadData()
        }
    }
    //MARK: - Setup Functions
    private func setupViews() -> Void {
        
        view.addSubviews(closeButton,
                         editButton,
                         deleteButton,
                         tableView)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(22)
            make.height.width.equalTo(22)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.right.equalTo(deleteButton.snp.left).offset(-14)
            make.height.width.equalTo(22)
        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.right.equalToSuperview().offset(-24)
            make.height.width.equalTo(26)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(deleteButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    @objc func tapDelete() {
        deleteAction?()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tapBack()
        }
    }
}
//MARK: - TableView Delegate
extension GoalDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        switch section {
        case .first , .second:
            return 1
        case .third:
            return goalModel?.history?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .first:
            let cell = tableView.dequeueReusableCell(withIdentifier: GoalProgressCell.cellId, for: indexPath) as! GoalProgressCell
            cell.configure(model: goalModel)
            cell.doneAction = {[weak self] in
                guard let self = self else {return}
                self?.doneAction?()
            }
            return cell
        case .second:
            let cell = tableView.dequeueReusableCell(withIdentifier: GoalWeekCell.cellId, for: indexPath) as! GoalWeekCell
            cell.configure(model: goalModel)
            return cell
        case .third:
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.cellId, for: indexPath) as! HistoryCell
            let histories = goalModel?.history?[indexPath.row]
            cell.configure(model: histories)
            if let isEmpty = goalModel?.history?.isEmpty, isEmpty {
                cell.isHidden = true
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        
        switch section {
        case .third:
            if let isEmpty = goalModel?.history?.isEmpty, isEmpty {
                return nil
            }
            return SectionHeaderView(title: "История")
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        
        switch section {
        case .third:
            return UITableView.automaticDimension
        case.second:
            return 0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        switch section {
        case .first, .second, .third:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
