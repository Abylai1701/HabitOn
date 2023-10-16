import UIKit

class HistoryCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        return container
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 11)
        label.textColor = .white
        label.text = "2 октября"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 11)
        label.textColor = .green
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var editButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "edit_icon2")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor2
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
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
        addSubviews(container)
        
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        container.addSubviews(dateLabel,
                              doneLabel,
                              editButton,
                              separatorView)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(12)
        }
        doneLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(12)
        }
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.width.equalTo(14)
            make.top.equalToSuperview().offset(17)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(doneLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(2)
            make.bottom.equalToSuperview().offset(-1)
        }
    }
    func configure(model: History?) {
        guard let model = model else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: model.date) {
            dateFormatter.dateFormat = "d MMMM"
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate
        }
        if model.done {
            doneLabel.text = "Выполнено"
        }else{
            doneLabel.text = "Не выполнено"
        }
    }
}
