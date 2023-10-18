import Foundation
import UIKit

enum HabbitsDetailMenuType {
    case first
    case second
    case third
}

final class HabbitDetailVC: UIViewController {
    
    //MARK: - Properties
    var sections: [HabbitsDetailMenuType] = [.first,
                                             .second,
                                             .third]
    
    private let viewModel: HabbitDetailViewModelLogic = HabbitDetailViewModel()
    private var habbitModel: HabbitDetailModel?
    private var id: Int

    var closeAction : (()->())?
    var shareAction: (()->())?
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    private lazy var shadowView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        btn.addTarget(self, action: #selector(tapShadow), for: .touchUpInside)
        return btn
    }()
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 30
        return container
    }()
    private lazy var closeButton: UIImageView = {
        view.isUserInteractionEnabled = true
        let view = UIImageView()
        view.image = UIImage(named: "exit_icon")
        view.contentMode = .scaleAspectFit
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
        table.register(HabbitDetailFirstCell.self,
                       forCellReuseIdentifier: HabbitDetailFirstCell.cellId)
        table.register(HabbitDetailSecondCell.self,
                       forCellReuseIdentifier: HabbitDetailSecondCell.cellId)
        table.register(HabbitDetailThirdCell.self,
                       forCellReuseIdentifier: HabbitDetailThirdCell.cellId)
        table.backgroundColor = .clear
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
        viewModel.fetchHabbitDetail(id: self.id)
    }
    func bind() {
        viewModel.habbitDetail.observe(on: self) { habbit in
            self.habbitModel = habbit
            self.tableView.reloadData()
        }
    }
    //MARK: - Setup Functions
    private func setupViews() -> Void {
        
        view.addSubviews(shadowView, container)
        container.isUserInteractionEnabled = true
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(560)
        }
        container.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        container.addSubviews(closeButton,
                              deleteButton,
                              tableView)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(22)
            make.height.width.equalTo(22)
        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-24)
            make.height.width.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(deleteButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    // MARK: - Actions
    @objc func tapShadow() -> Void {
        tapClose()
    }
    @objc func tapClose() -> Void {
        dismiss(animated: true, completion: nil)
        closeAction?()
    }
    @objc func tapShare() {
        tapClose()
        shareAction?()
    }
    @objc func tapDelete() {
        viewModel.removeHabbit(id: self.id)
        tapClose()
    }
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: container)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.container.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            case .ended:
                if viewTranslation.y < 200 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.container.transform = .identity
                    })
                } else {
                    view.backgroundColor = .clear
                    dismiss(animated: true, completion: nil)
                }
            default:
                break
            }
    }
}
//MARK: - TableView Delegate
extension HabbitDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        switch section {
        case .first , .second:
            return 1
        case .third:
            return habbitModel?.periods?.count ?? 8
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .first:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabbitDetailFirstCell.cellId, for: indexPath) as! HabbitDetailFirstCell
            cell.configure(model: habbitModel)
            return cell
        case .second:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabbitDetailSecondCell.cellId, for: indexPath) as! HabbitDetailSecondCell
            cell.configure(model: habbitModel)
            return cell
        case .third:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabbitDetailThirdCell.cellId, for: indexPath) as! HabbitDetailThirdCell
            
            let histories = habbitModel?.periods?[indexPath.row]
            cell.configure(model: histories)

            if let isEmpty = habbitModel?.periods?.isEmpty, isEmpty {
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
            let view = SectionHeaderView(title: "История")
            view.container.backgroundColor = .blueColor2
            return view
        default:
           return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        
        switch section {
        case .third:
            return UITableView.automaticDimension
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
