import UIKit
final class UserNotFindedView: BaseView {
    private let icon = UIImageView()
    private let label1 = UILabel()
    private let label2 = UILabel()
}
extension UserNotFindedView {
    override func addViews() {
        addSubview(icon)
        addSubview(label1)
        addSubview(label2)
    }
    override func layoutViews() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            label1.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            label1.centerXAnchor.constraint(equalTo: centerXAnchor),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 10),
            label2.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    override func configure() {
        icon.image = Resouces.Images.Common.Glass
        label1.text = "Мы никого не нашли"
        label1.font = Resouces.Fonts.InterSemiBold(with: 17)
        label1.textColor = Resouces.Colors.Black1
        label2.text = "Попробуй скорректировать запрос"
        label2.font = Resouces.Fonts.InterSemiBold(with: 16)
        label2.textColor = Resouces.Colors.Gray2
    }
}
