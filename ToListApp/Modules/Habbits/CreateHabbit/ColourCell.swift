import UIKit

class ColourCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let borderLayer = CALayer()
    
    private lazy var colour: UIButton = {
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
        layer.borderWidth = 5
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 22.5
        contentView.isUserInteractionEnabled = true

        addSubview(colour)
        colour.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(45)
        }
    }
    
    
    
    //MARK: - Actions
    
}
