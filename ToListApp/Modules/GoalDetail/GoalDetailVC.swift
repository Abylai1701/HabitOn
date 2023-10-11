import Foundation
import UIKit

final class GoalDetailVC: UIViewController {
    
    //MARK: - Properties
    var closeAction : (()->())?
    var shareAction: (()->())?
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    private lazy var shadowView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        btn.addTarget(self, action: #selector(tapShadow), for: .touchUpInside)
        return btn
    }()
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 30
        return container
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
    }
    
    //MARK: - Setup Functions
    private func setupViews() -> Void {
        
        view.addSubviews(shadowView, container)
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        container.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(466)
        }
        container.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
    }
    // MARK: - Actions
    @objc func tapShadow() -> Void {
        tapClose()
        closeAction?()
    }
    @objc func tapClose() -> Void {
        dismiss(animated: true, completion: nil)
        closeAction?()
    }
    @objc func tapShare() {
        tapClose()
        shareAction?()
    }
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: container)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.container.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            case .ended:
                if viewTranslation.y < 200 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.container.transform = .identity
                    })
                } else {
                    view.backgroundColor = .clear
                    dismiss(animated: true, completion: nil)
                }
            default:
                break
            }
    }
}
