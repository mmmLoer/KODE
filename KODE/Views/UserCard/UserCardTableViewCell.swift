import Foundation

import UIKit

class UserCardTableViewCell: UITableViewCell {
    let userCardView = UserCardView()
    let sampleCard = SampleCardView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setsample() {
        contentView.addSubview(sampleCard)
        sampleCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sampleCard.heightAnchor.constraint(equalToConstant: 84),
            sampleCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            sampleCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sampleCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sampleCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    func configure( user: Item, birthday: Bool) {
        if birthday {
            userCardView.userBirthday.isHidden = false
        } else {
            userCardView.userBirthday.isHidden = true
        }
        contentView.addSubview(userCardView)
        userCardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userCardView.heightAnchor.constraint(equalToConstant: 84),
            userCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        loadImage(from: user.avatarURL) { [self] image in
            if let image = image {
                userCardView.setImage(userImage: image)
            } else {
                print("Не удалось загрузить изображение.")
            }
        }
        userCardView.setData(firstName: user.firstName, secondName: user.lastName, userTag: user.userTag.lowercased(), userDepartment: transformString(user.department), userBirthday: dateFormatSmall(date: user.birthday))
    }
}
