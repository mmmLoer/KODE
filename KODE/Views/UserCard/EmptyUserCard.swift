import UIKit

final class SampleCardView: BaseView {
    private let userTagGradientLayer = CAGradientLayer()
    private let userImage = UIView()
    private let userName = UIView()
    private let userTag = UIView()
}
extension SampleCardView {
    override func addViews() {
        addSubview(userImage)
        addSubview(userName)
        addSubview(userTag)
    }
    override func layoutViews() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImage.heightAnchor.constraint(equalToConstant: 72),
            userImage.widthAnchor.constraint(equalToConstant: 72),
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            userName.heightAnchor.constraint(equalToConstant: 16),
            userName.widthAnchor.constraint(equalToConstant: 144),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            userTag.heightAnchor.constraint(equalToConstant: 12),
            userTag.widthAnchor.constraint(equalToConstant: 80),
            userTag.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
            userTag.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6)
        ])
    }
    override func configure() {
        backgroundColor = .white
        userImage.layer.masksToBounds = true
        userName.clipsToBounds = true
        userTag.clipsToBounds = true
        userName.layer.cornerRadius = 8
        userTag.layer.cornerRadius = 6
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUserTagGradient()
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
    }
    private func setupUserTagGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hexString: "#F3F3F6").cgColor,
            UIColor(hexString: "#FAFAFA").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = userTag.bounds
        gradientLayer.cornerRadius = userTag.layer.cornerRadius
        userTag.layer.insertSublayer(gradientLayer, at: 0)

        let userNamegradientLayer = CAGradientLayer()
        userNamegradientLayer.colors = [
            UIColor(hexString: "#F3F3F6").cgColor,
            UIColor(hexString: "#FAFAFA").cgColor
        ]
        userNamegradientLayer.locations = [0.0, 1.0]
        userNamegradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        userNamegradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        userNamegradientLayer.frame = userName.bounds
        userNamegradientLayer.cornerRadius = userName.layer.cornerRadius
        userName.layer.insertSublayer(userNamegradientLayer, at: 0)

        let userImagegradientLayer = CAGradientLayer()
        userImagegradientLayer.colors = [
            UIColor(hexString: "#F3F3F6").cgColor,
            UIColor(hexString: "#FAFAFA").cgColor
        ]
        userImagegradientLayer.locations = [0.0, 1.0]
        userImagegradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        userImagegradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        userImagegradientLayer.frame = userImage.bounds
        userImagegradientLayer.cornerRadius = userImage.layer.cornerRadius
        userImage.layer.insertSublayer(userImagegradientLayer, at: 0)

    }
}
