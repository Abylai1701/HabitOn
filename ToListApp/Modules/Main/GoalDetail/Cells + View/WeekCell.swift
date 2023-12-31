import UIKit

class WeekCell: UICollectionViewCell {
    //MARK: - Properties
    private let borderLayer = CALayer()
    
    private lazy var label: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueText
        button.layer.cornerRadius = 22.5
        button.layer.masksToBounds = true
        return button
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //MARK: - Setup Views
    private func setupViews() {
        label.isUserInteractionEnabled = false
        contentView.isUserInteractionEnabled = true
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(45)
        }
    }
    
    func configure(day: WeekDayModel) {
        label.setTitle(day.type.title, for: .normal)
        if day.isSelected {
            layer.borderWidth = 5
            layer.borderColor = UIColor.white.cgColor
        }else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
        layer.cornerRadius = 22.5
    }
}
