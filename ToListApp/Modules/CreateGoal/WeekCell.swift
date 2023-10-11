import UIKit

class WeekCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var label: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "21"),
                        for: .normal)
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
        contentView.isUserInteractionEnabled = true
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(45)
        }
    }
    
    
    
    //MARK: - Actions
    
}
