import UIKit

class MenuCell: UITableViewCell {
    
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "Ерка Педик"
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var arrowRight: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow_right")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.masksToBounds = true
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        
        addSubviews(menuLabel,
                    arrowRight)
        
        menuLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        arrowRight.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(12)
        }
    }
    
    func configure(model: ProfileMenuType) {
        menuLabel.text = model.title
    }
}
