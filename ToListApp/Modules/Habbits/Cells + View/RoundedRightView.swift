import UIKit

class RoundedRightView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }

    private func roundCorners() {
        let cornerRadius: CGFloat = 30
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topRight, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
