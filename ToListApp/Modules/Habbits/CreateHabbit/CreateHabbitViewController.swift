import Foundation
import UIKit

enum ColorsType: String {
    case scarlet = "scarlet"
    case yellow = "yellow"
    case green = "green"
    case whiteBlue = "whiteBlue"
    case blue = "blue"
    case phiolet = "purple"
    case red = "red"
    case null
    
    var color: UIColor {
        switch self {
        case .scarlet: return .scarletColor
        case .yellow: return .yellowColor2
        case .green: return .greenColor
        case .whiteBlue: return .whiteBlue2
        case .blue: return .blue
        case .phiolet: return .purple
        case .red: return .red
        case .null: return .white
        }
    }
}

extension ColorsType: Codable {
    public init(from decoder: Decoder) throws {
        self = try ColorsType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .null
    }
}

final class CreateHabbitViewController: UIViewController {
    
    //MARK: - Properties
    let viewModel: CreateHabbitViewModelLogic = CreateHabbitViewModel()
    
    let colors: [ColorsType] = [.scarlet,
                                .yellow,
                                .green,
                                .whiteBlue,
                                .blue,
                                .phiolet,
                                .red]
    
    var selectedColorIndex: Int?
    var selectedColor: String?
    
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
    private lazy var habbitField: UITextField = {
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
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 45, height: 45)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.allowsSelection = true
        collection.showsHorizontalScrollIndicator = false
        collection.register(ColourCell.self, forCellWithReuseIdentifier: ColourCell.cellId)
        return collection
    }()
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .montserratSemiBold(ofSize: 14)
        button.setTitle("Create habbit".localized,
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
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(250)
        }
        container.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        container.addSubviews(habbitField,
                              collectionView,
                              createButton)
        habbitField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(habbitField.snp.bottom).offset(16)
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
        tapClose()
    }
    @objc func tapClose() -> Void {
        dismiss(animated: true, completion: nil)
        closeAction?()
    }
    @objc
    func tapCreate() -> Void {
        guard let name = habbitField.text,
              let color = selectedColor else {
            return
        }
        viewModel.createHabbit(name: name, color: color)
        tapShadow()
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
extension CreateHabbitViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { colors.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColourCell.cellId, for: indexPath) as! ColourCell
        cell.configure(color: colors[indexPath.row], isSelected: indexPath.row == selectedColorIndex)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorIndex = indexPath.row
        selectedColor = colors[selectedColorIndex ?? 0].rawValue // Сохраните выбранный цвет
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {8}
}
