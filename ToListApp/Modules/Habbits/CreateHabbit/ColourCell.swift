import UIKit

class ColourCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let borderLayer = CALayer()
    
    private lazy var color: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .greenColor
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
        color.isUserInteractionEnabled = false
        
        contentView.isUserInteractionEnabled = true
        
        addSubview(color)
        color.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(45)
        }
    }
    //MARK: - Actions
    func configure(color: ColorsType, isSelected: Bool) {
        self.color.backgroundColor = color.color
        
        if isSelected {
            layer.borderWidth = 5
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
        layer.cornerRadius = 22.5
    }
    func configureDetail(color: ColorModel) {
        self.color.backgroundColor = color.type.color
        if color.isSelected {
            layer.borderWidth = 5
            layer.borderColor = UIColor.white.cgColor
        }else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
        layer.cornerRadius = 22.5
    }
}
