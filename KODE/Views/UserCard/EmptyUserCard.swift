import UIKit

final class SampleCardView: BaseView {
    private let userTagGradientLayer = CAGradientLayer()
    private let UserImage = UIView()
    private let UserName = UIView()
    private let UserTag = UIView()
}
extension SampleCardView {
    override func addViews() {
        addSubview(UserImage)
        addSubview(UserName)
        addSubview(UserTag)
    }
    override func layoutViews() {
        UserImage.translatesAutoresizingMaskIntoConstraints = false
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            UserImage.heightAnchor.constraint(equalToConstant: 72),
            UserImage.widthAnchor.constraint(equalToConstant: 72),
            UserImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            UserName.heightAnchor.constraint(equalToConstant: 16),
            UserName.widthAnchor.constraint(equalToConstant: 144),
            UserName.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 16),
            UserName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            UserTag.heightAnchor.constraint(equalToConstant: 12),
            UserTag.widthAnchor.constraint(equalToConstant: 80),
            UserTag.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 16),
            UserTag.topAnchor.constraint(equalTo: UserName.bottomAnchor, constant: 6)
        ])
    }
    override func configure() {
        backgroundColor = .white
        UserImage.layer.masksToBounds = true
        UserName.clipsToBounds = true
        UserTag.clipsToBounds = true
        UserName.layer.cornerRadius = 8
        UserTag.layer.cornerRadius = 6
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUserTagGradient()
        UserImage.layer.cornerRadius = UserImage.frame.size.width / 2
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
        gradientLayer.frame = UserTag.bounds
        gradientLayer.cornerRadius = UserTag.layer.cornerRadius
        UserTag.layer.insertSublayer(gradientLayer, at: 0)

        let userNamegradientLayer = CAGradientLayer()
        userNamegradientLayer.colors = [
            UIColor(hexString: "#F3F3F6").cgColor,
            UIColor(hexString: "#FAFAFA").cgColor
        ]
        userNamegradientLayer.locations = [0.0, 1.0]
        userNamegradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        userNamegradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        userNamegradientLayer.frame = UserName.bounds
        userNamegradientLayer.cornerRadius = UserName.layer.cornerRadius
        UserName.layer.insertSublayer(userNamegradientLayer, at: 0)

        let userImagegradientLayer = CAGradientLayer()
        userImagegradientLayer.colors = [
            UIColor(hexString: "#F3F3F6").cgColor,
            UIColor(hexString: "#FAFAFA").cgColor
        ]
        userImagegradientLayer.locations = [0.0, 1.0]
        userImagegradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        userImagegradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        userImagegradientLayer.frame = UserImage.bounds
        userImagegradientLayer.cornerRadius = UserImage.layer.cornerRadius
        UserImage.layer.insertSublayer(userImagegradientLayer, at: 0)

    }
}
