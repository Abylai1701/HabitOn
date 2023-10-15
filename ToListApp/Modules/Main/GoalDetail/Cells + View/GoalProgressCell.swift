import UIKit

class GoalProgressCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var containerDone: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 15
        return container
    }()
    private lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .white
        label.text = "Выполнено"
        label.numberOfLines = 1
        return label
    }()
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 15
        return container
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .white
        label.text = "Running"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.textColor = .white
        label.text = "Reminder: Friday at 15:00"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var progressView: CircularProgressView = {
        let view = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), lineWidth: 10, rounded: false)
        view.trackColor = .white
        view.progressColor = .whiteBlue
        return view
    }()
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 12)
        label.textColor = .white
        label.text = "12/10"
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
        backgroundColor = .white
        addSubviews(containerDone,container)
        
        containerDone.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(45)
        }
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(containerDone.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        containerDone.addSubview(doneLabel)
        
        doneLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        container.addSubviews(titleLabel,
                              reminderLabel,
                              progressView,
                              countLabel)
        progressView.center = center
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.right.lessThanOrEqualTo(progressView.snp.left).offset(-4)
        }
        reminderLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(progressView.snp.left).offset(-4)
            make.bottom.equalToSuperview().offset(-16)
        }
        progressView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(60)
        }
        countLabel.snp.makeConstraints { make in
            make.center.equalTo(progressView)
        }
        progressView.progress = 0.6
    }
    func configure(model: GoalDetailModel?) {
        guard let model = model else {
            return
        }
        titleLabel.text = model.name
        let progress = Int((model.iterationCount ?? 500))
        progressView.progress = Float(progress) * 0.04
        countLabel.text = "\(model.iterationCount ?? 6)"
    }
}
