import UIKit

class HabbitDetailFirstCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var rebootButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .scarletColor
        button.layer.cornerRadius = 22
        button.setTitle("Перезагрузить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.blueColor, for: .normal)

        return button
    }()
    private lazy var habbitField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.text = "Goal"
        field.layer.borderColor = UIColor.white.cgColor
        field.font = .montserratSemiBold(ofSize: 14)
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 16,
                                            height: 16))
        field.leftView = iconView
        field.leftViewMode = .always
        field.textColor = .white
        return field
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
        collection.register(ColourCell.self, forCellWithReuseIdentifier: ColourCell.cellId)
        return collection
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
        addSubviews(rebootButton,
                    habbitField,
                    collectionView)
        
        rebootButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(45)
            make.top.equalToSuperview().offset(14)
        }
        habbitField.snp.makeConstraints { make in
            make.top.equalTo(rebootButton.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(habbitField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(45)
            make.bottom.equalToSuperview()
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

extension HabbitDetailFirstCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 7 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColourCell.cellId, for: indexPath) as! ColourCell
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {8}
}
