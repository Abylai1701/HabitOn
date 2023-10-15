import UIKit

class SectionHeaderView: UIView {
    
    //MARK: - Properties
    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return container
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .montserratSemiBold(ofSize: 16)
        return label
    }()
    //MARK: - Init
    init(title: String?) {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        addSubview(container)
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        container.addSubviews(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview()
        }
        titleLabel.text = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
