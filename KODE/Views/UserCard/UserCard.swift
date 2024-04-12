import UIKit

final class UserCardView: BaseView {
    private let userImage = UIImageView()
    private let userName = UILabel()
    let userBirthday = UILabel()
    private let userTag = UILabel()
    private let userDepartment = UILabel()
    func setData(firstName: String, secondName: String, userTag: String, userDepartment: String, userBirthday: String) {
        userName.text = "\(firstName) \(secondName)"
        self.userTag.text = userTag
        self.userDepartment.text = userDepartment
        self.userBirthday.text = userBirthday
    }
    func setImage(userImage: UIImage) {
        self.userImage.image = userImage
    }
}
extension UserCardView {
    override func addViews() {
        addSubview(userBirthday)
        addSubview(userImage)
        addSubview(userName)
        addSubview(userTag)
        addSubview(userDepartment)
    }
    override func layoutViews() {
        userBirthday.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userDepartment.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userBirthday.centerYAnchor.constraint(equalTo: centerYAnchor),
            userBirthday.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userImage.heightAnchor.constraint(equalToConstant: 72),
            userImage.widthAnchor.constraint(equalToConstant: 72),
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            userTag.leadingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 5),
            userTag.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            userDepartment.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
            userDepartment.topAnchor.constraint(equalTo: userTag.bottomAnchor, constant: 3)

        ])
    }
    override func configure() {
        backgroundColor = .white
        userImage.image = Resouces.Images.Common.UserImage
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = Resouces.Colors.Purple1
        userImage.layer.cornerRadius = 36

        userName.font = Resouces.Fonts.interMedium(with: 16)
        userName.textColor = .black

        userTag.font = Resouces.Fonts.interMedium(with: 14)
        userTag.textColor = .gray

        userDepartment.font = Resouces.Fonts.interRegular(with: 13)
        userDepartment.textColor = .gray

        userBirthday.font = Resouces.Fonts.interRegular(with: 15)
        userBirthday.textColor = .gray
    }
}
