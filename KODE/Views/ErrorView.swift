import UIKit
final class ErrorView: BaseView {
    let label = UILabel()
}
extension ErrorView {
    override func addViews() {
        addSubview(label)
    }
    override func layoutViews() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
    override func configure() {
        backgroundColor = Resouces.Colors.Red1
        label.font = Resouces.Fonts.InterMedium(with: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
    }
}
