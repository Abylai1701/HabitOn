import UIKit

class HabbitCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var mainView: RoundedRightView = {
        let view = RoundedRightView()
        view.backgroundColor = .greenColor
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .white
        label.text = "Whitout taxi"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 14)
        label.textColor = .white
        label.text = "000"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup Views
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        
        addSubviews(mainView)
        
        mainView.addSubviews(titleLabel,timeLabel)
        
        mainView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(8)
            make.right.lessThanOrEqualToSuperview().offset(-12)
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.lessThanOrEqualToSuperview().offset(-12)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    func configure(model: HabbitModel) {
        titleLabel.text = model.name
        if model.color == "black" {
            mainView.backgroundColor = .black
        }
    }
}
