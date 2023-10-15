import UIKit

class MainCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .blueText
        label.text = "Running"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.textColor = .blueText
        label.text = "Reminder: Friday at 15:00"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var progressView: CircularProgressView = {
        let view = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), lineWidth: 10, rounded: false)
        view.trackColor = .blueColor
        view.progressColor = .whiteBlue
        return view
    }()
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 12)
        label.textColor = .blueText
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
        addSubviews(titleLabel,
                    reminderLabel,
                    progressView,
                    countLabel
        )
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
    }
    
    func configure(model: GoalModel) {
        titleLabel.text = model.name
        let progress = Int((model.currentSeries * 100)/model.iterationCount)
        progressView.progress = Float(progress) * 0.01
        countLabel.text = "\(model.iterationCount)/\(model.currentSeries)"
    }
}
