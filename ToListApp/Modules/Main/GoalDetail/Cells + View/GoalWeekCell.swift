import UIKit

enum DayOfWeek {
    case monday
    case thuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var title:String {
        switch self {
        case .monday: return "Пн"
        case .thuesday: return "Вт"
        case .wednesday: return "Ср"
        case .thursday: return "Чт"
        case .friday: return "Пт"
        case .saturday: return "Сб"
        case .sunday: return "Вс"
        }
    }
}

class GoalWeekCell: UITableViewCell {
    
    //MARK: - Properties
    private var weekModel: GoalDetailModel? = nil
    let days: [DayOfWeek] = [.monday,
                             .thuesday,
                             .wednesday,
                             .thursday,
                             .friday,
                             .saturday,
                             .sunday]
    
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
        label.text = "Дни повторения"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 45, height: 45)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.allowsSelection = true
        collection.showsHorizontalScrollIndicator = false
        collection.register(WeekCell.self, forCellWithReuseIdentifier: WeekCell.cellId)
        return collection
    }()
    private lazy var container2: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 13
        return container
    }()
    private lazy var miniCup: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mini_cup_icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var recordTime: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .white
        label.text = "18 раз подряд"
        label.numberOfLines = 1
        return label
    }()
    private lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.textColor = .grayColor
        label.text = "главный рекорд"
        label.numberOfLines = 1
        return label
    }()
    private lazy var currentTime: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .white
        label.text = ""
        label.numberOfLines = 1
        return label
    }()
    private lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.textColor = .grayColor
        label.text = "текущий счет"
        label.numberOfLines = 1
        return label
    }()
    private lazy var cup: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cup")
        view.contentMode = .scaleAspectFit
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
        addSubviews(container,container2)
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        container.addSubviews(titleLabel,collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-8)
        }
        container2.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(container.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        container2.addSubviews(miniCup,
                               recordTime,
                               recordLabel,
                               currentTime,
                               currentLabel,
                               cup)
        
        miniCup.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(15)
            make.top.equalToSuperview().offset(20)
        }
        recordTime.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalTo(miniCup.snp.right).offset(4)
        }
        recordLabel.snp.makeConstraints { make in
            make.top.equalTo(recordTime.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(10)
        }
        
        currentTime.snp.makeConstraints { make in
            make.top.equalTo(recordLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(10)
        }
        currentLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTime.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-14)
        }
        cup.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(60)
            make.top.equalToSuperview().offset(30)
        }
    }
    func configure(model: GoalDetailModel?) {
        self.weekModel = model
        self.currentTime.text = "\(model?.currentSeries ?? 667) раз"
        self.recordTime.text = "\(model?.longestSeries ?? 667) раз подряд"
        self.collectionView.reloadData()
    }
}
extension GoalWeekCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 7 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCell.cellId, for: indexPath) as! WeekCell
        let days = self.days[indexPath.row]
        cell.configure(day: days, model: weekModel )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {8}
}
