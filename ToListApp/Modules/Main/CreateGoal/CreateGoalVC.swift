import Foundation
import UIKit

final class CreateGoalVC: UIViewController {
    
    //MARK: - Properties
    let viewModel: CreateGoalViewModelLogic = CreateGoalViewModel()
    var selectedDays: [String] = []
    let days: [DayOfWeek] = [.monday,
                             .tuesday,
                             .wednesday,
                             .thursday,
                             .friday,
                             .saturday,
                             .sunday]
    var daysModel: [WeekDayModel] = []
    
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
    private lazy var goalField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.text = "Goal"
        field.layer.borderColor = UIColor.white.cgColor
        field.font = .montserratSemiBold(ofSize: 14)
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 16,
                                            height: 16))
        field.leftView = iconView
        field.leftViewMode = .always
        field.textColor = .white
        return field
    }()
    private lazy var notifyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Group"),
                        for: .normal)
        button.backgroundColor = .blueText
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    private lazy var n21Button: UITextField = {
        let field = UITextField()
        field.backgroundColor = .blueText
        field.text = "21"
        field.font = .montserratSemiBold(ofSize: 24)
        field.layer.cornerRadius = 30
        field.layer.masksToBounds = true
        field.textAlignment = .center
        field.textColor = .white
        return field
    }()
    private lazy var repeatLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .white
        label.text = "repeat_every_day".localized
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var checkBox: CheckBox = {
        let view = CheckBox()
        view.isChecked = false
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 45, height: 45)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.allowsSelection = true
        collection.isUserInteractionEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.register(WeekCell.self, forCellWithReuseIdentifier: WeekCell.cellId)
        return collection
    }()
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .montserratSemiBold(ofSize: 14)
        button.setTitle("create_goal".localized,
                        for: .normal)
        button.setTitleColor(.blueColor,
                             for: .normal)
        button.setImage(UIImage(named:"File add 1"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 24
        )
        button.addTarget(self, action: #selector(tapCreate), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
    }
    //MARK: - Setup Functions
    private func setupViews() -> Void {
        
        view.addSubviews(shadowView, container)
        
        for day in days {
            daysModel.append(WeekDayModel(isSelected: false,
                                          type: day))
        }
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(380)
        }
        container.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        container.addSubviews(goalField, notifyButton, n21Button,
                              repeatLabel, checkBox, collectionView,
                              createButton)
        goalField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        notifyButton.snp.makeConstraints { make in
            make.top.equalTo(goalField.snp.bottom).offset(40)
            make.width.height.equalTo(60)
            make.left.equalToSuperview().offset(64)
        }
        n21Button.snp.makeConstraints { make in
            make.top.equalTo(goalField.snp.bottom).offset(40)
            make.width.height.equalTo(60)
            make.right.equalToSuperview().offset(-64)
        }
        repeatLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(n21Button.snp.bottom).offset(22)
        }
        checkBox.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.width.equalTo(21)
            make.centerY.equalTo(repeatLabel)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(checkBox.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(45)
        }
        createButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(48)
            make.width.equalTo(203)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    // MARK: - Actions
    @objc func tapShadow() -> Void {
        dismiss(animated: true, completion: nil)
    }
    @objc func tapClose() -> Void {
        dismiss(animated: true, completion: nil)
        closeAction?()
    }
    @objc func tapShare() {
        tapClose()
    }
    @objc
    func tapCreate() {
        guard let name = n21Button.text, !selectedDays.isEmpty else {return}

        viewModel.createGoal(name: goalField.text ?? "Goal", iteration_count: Int(name) ?? 21, days: selectedDays)
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
extension CreateGoalVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { daysModel.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCell.cellId, for: indexPath) as! WeekCell
        cell.configure(day: daysModel[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = daysModel[indexPath.row].type

        if let index = selectedDays.firstIndex(of: day.rawValue) {
            // Если день уже выбран, удаляем его из массива
            selectedDays.remove(at: index)
        } else {
            // Если день не выбран, добавляем его в массив
            selectedDays.append(day.rawValue)
        }

        daysModel[indexPath.row].isSelected = !daysModel[indexPath.row].isSelected
        collectionView.reloadItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {8}
}
