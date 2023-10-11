import UIKit

class MenuNotificationCell: UITableViewCell {
    
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "Ерка Педик"
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        return mySwitch
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
                    mySwitch)
        
        menuLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        mySwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(model: ProfileMenuType) {
        menuLabel.text = model.title
    }
}
