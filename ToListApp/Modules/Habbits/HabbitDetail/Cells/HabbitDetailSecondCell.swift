import UIKit

class HabbitDetailSecondCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor2
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
        label.text = "26д 12ч 12м"
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
        label.text = "26д 12ч 12м  "
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
        addSubview(container)
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        container.addSubviews(miniCup,
                              recordTime,
                              recordLabel,
                              currentTime,
                              currentLabel)
        
        miniCup.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(15)
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
    }
    
    //MARK: - Configure
//    func configure(model: [EventModel]) {
//        self.events = model
//        collectionView.snp.updateConstraints { make in
//            make.height.equalTo(model.count>0 ? 200 : 0)
//        }
//        self.collectionView.reloadData()
//    }
}
