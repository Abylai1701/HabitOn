import UIKit

class DoneView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Done"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        backgroundColor = .green
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-28)
        }
    }
}
