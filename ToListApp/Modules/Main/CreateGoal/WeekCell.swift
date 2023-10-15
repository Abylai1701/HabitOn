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
        layer.borderWidth = 5 // Измените толщину линии по вашему выбору
        layer.borderColor = UIColor.blueColor.cgColor
        layer.cornerRadius = 22.5
        contentView.isUserInteractionEnabled = true
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(45)
        }
    }
    
    func configure(day: DayOfWeek, model: GoalDetailModel?) {
        label.setTitle(day.title, for: .normal)
        if let days = model?.days {
            if days.contains("mn") || days.contains("gy") || days.contains("sg") || days.contains("hs") || days.contains("st") || days.contains("hs") || days.contains("vx") {
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}
