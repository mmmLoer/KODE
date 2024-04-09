import UIKit

final class UserCardView: BaseView {
    private let UserImage = UIImageView()
    private let UserName = UILabel()
    let UserBirthday = UILabel()
    private let UserTag = UILabel()
    private let UserDepartment = UILabel()
    func setData(firstName: String, secondName: String, userTag: String, userDepartment: String, userBirthday: String) {
        UserName.text = "\(firstName) \(secondName)"
        UserTag.text = userTag
        UserDepartment.text = userDepartment
        UserBirthday.text = userBirthday
    }
    func setImage(userImage: UIImage) {
        UserImage.image = userImage
    }
}
extension UserCardView {
    override func addViews() {
        addSubview(UserBirthday)
        addSubview(UserImage)
        addSubview(UserName)
        addSubview(UserTag)
        addSubview(UserDepartment)
    }
    override func layoutViews() {
        UserBirthday.translatesAutoresizingMaskIntoConstraints = false
        UserImage.translatesAutoresizingMaskIntoConstraints = false
        UserDepartment.translatesAutoresizingMaskIntoConstraints = false
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            UserBirthday.centerYAnchor.constraint(equalTo: centerYAnchor),
            UserBirthday.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            UserImage.heightAnchor.constraint(equalToConstant: 72),
            UserImage.widthAnchor.constraint(equalToConstant: 72),
            UserImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            UserName.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 16),
            UserName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            UserTag.leadingAnchor.constraint(equalTo: UserName.trailingAnchor, constant: 5),
            UserTag.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            UserDepartment.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 16),
            UserDepartment.topAnchor.constraint(equalTo: UserTag.bottomAnchor, constant: 3)

        ])
    }
    override func configure() {
        backgroundColor = .white
        UserImage.image = Resouces.Images.Common.UserImage
        UserImage.layer.masksToBounds = true
        UserImage.backgroundColor = Resouces.Colors.Purple1
        UserImage.layer.cornerRadius = 36

        UserName.font = Resouces.Fonts.InterMedium(with: 16)
        UserName.textColor = .black

        UserTag.font = Resouces.Fonts.InterMedium(with: 14)
        UserTag.textColor = .gray

        UserDepartment.font = Resouces.Fonts.InterRegular(with: 13)
        UserDepartment.textColor = .gray

        UserBirthday.font = Resouces.Fonts.InterRegular(with: 15)
        UserBirthday.textColor = .gray
    }
}
