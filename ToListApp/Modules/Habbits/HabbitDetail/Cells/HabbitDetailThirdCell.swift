import UIKit

class HabbitDetailThirdCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor2
        container.clipsToBounds = true
        return container
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 11)
        label.textColor = .white
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 11)
        label.textColor = .green
        label.text = "Done"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
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
        backgroundColor = .clear
        addSubviews(container)
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        container.addSubviews(dateLabel,
                              doneLabel,
                              separatorView)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(12)
        }
        doneLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(12)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(doneLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(2)
            make.bottom.equalToSuperview().offset(-1)
        }
    }
    func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
        return ""
    }
    
    func calculateEndDate(startDate: String, interval: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        
        var time = ""
        
        if let startDate = dateFormatter.date(from: startDate) {
            var components = DateComponents()
            print(startDate)
            // Разбираем интервал на компоненты (дни, часы, минуты)
            let intervalComponents = interval.components(separatedBy: " ")
            let numberOfElements = intervalComponents.count
            if numberOfElements == 6 {
                if let days = Int(intervalComponents[0]) {
                    components.day = days
                }
                if let hours = Int(intervalComponents[3]) {
                    components.hour = hours
                }
                if let minutes = Int(intervalComponents[5]) {
                    components.minute = minutes
                }
                
                // Вычисляем дату окончания
                if let endDate = calendar.date(byAdding: components, to: startDate) {
                    let formattedStartDate = formatDateString(dateFormatter.string(from: startDate))
                    let formattedEndDate = formatDateString(dateFormatter.string(from: endDate))
                    time =  "\(formattedStartDate) - \(formattedEndDate)"
                }
            }
        }
        return time
    }
    
    func configure(model: Period?) {
        guard let model = model else {
            return
        }
        let startDate = model.start
        let interval = model.interval
        let endDateString = calculateEndDate(startDate: startDate, interval: interval)
        dateLabel.text = endDateString
        doneLabel.text = convertTimeIntervalString(interval)
    }
}
